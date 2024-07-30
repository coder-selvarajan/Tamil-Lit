//
//  DailyPoemViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/07/24.
//

import SwiftUI
import CoreData

class DailyPoemViewModel: ObservableObject {
    @Published var poemOftheDay: Poem?
    @Published var categoryDisplay: String = ""
    @Published var firstDailyPoemDate: Date?
    
    func getPoemOftheDay() {
        firstDailyPoemDate = CoreDataManager.shared.fetchMinimumDateInDailyPoem()
        getDailyPoemFor(Date())
    }
    
    func getthePoemOftheDay() -> Poem? {
        return getDailyPoem(for: Date())
    }
    
    func getDailyPoemFor(_ date: Date) {
        poemOftheDay = getDailyPoem(for: date) // poem for today
        
        if let section = poemOftheDay?.sectionname, section != "", !section.starts(with: "பாடல்") {
            categoryDisplay = " - " + section
        } else if let subCat = poemOftheDay?.subcategoryname, subCat != "", !subCat.starts(with: "பாடல்") {
            categoryDisplay = " - " + subCat
        } else if let mainCat = poemOftheDay?.maincategoryname, mainCat != "", !mainCat.starts(with: "பாடல்") {
            categoryDisplay = " - " + mainCat
        } else {
            categoryDisplay = ""
        }
    }
    
    private func getDailyPoem(for date: Date) -> Poem? {
        let includingBookNames: [String] = ["திருக்குறள்", "நாலடியார்", "ஆசாரக் கோவை", "நான்மணிக்கடிகை", "பழமொழி நானூறு"]

        if let dailyPoem = CoreDataManager.shared.fetchDailyPoem(for: date, includingBookNames: includingBookNames) {
            return dailyPoem
        }
        
        return nil
    }
}
