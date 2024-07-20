//
//  HomeViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 19/07/24.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    @Published var poemOftheDay: Poem?
    @Published var categoryDisplay: String = ""
    
    func getPoemOftheDay() {
        poemOftheDay = CoreDataManager.shared.fetchRandomPoem()
        
        if let section = poemOftheDay?.sectionname, section != "", !section.starts(with: "பாடல்") {
            categoryDisplay = section
        } else if let subCat = poemOftheDay?.subcategoryname, subCat != "", !subCat.starts(with: "பாடல்") {
            categoryDisplay = subCat
        } else if let mainCat = poemOftheDay?.maincategoryname, mainCat != "", !mainCat.starts(with: "பாடல்") {
            categoryDisplay = mainCat
        } else {
            categoryDisplay = ""
        }
    }
}
