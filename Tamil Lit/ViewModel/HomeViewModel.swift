//
//  HomeViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 19/07/24.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    @Published var bookViewSummaryList: [BookViewedSummary] = []
    
//    @Published var poemOftheDay: Poem?
//    @Published var categoryDisplay: String = ""
//    
//    func getPoemOftheDay() {
//        poemOftheDay = CoreDataManager.shared.fetchRandomPoem(excludingBookNames: [])
//        
//        if let section = poemOftheDay?.sectionname, section != "", !section.starts(with: "பாடல்") {
//            categoryDisplay = " - " + section
//        } else if let subCat = poemOftheDay?.subcategoryname, subCat != "", !subCat.starts(with: "பாடல்") {
//            categoryDisplay = " - " + subCat
//        } else if let mainCat = poemOftheDay?.maincategoryname, mainCat != "", !mainCat.starts(with: "பாடல்") {
//            categoryDisplay = " - " + mainCat
//        } else {
//            categoryDisplay = ""
//        }
//    }
    
    
    func getAllBookViewSummry() {
        bookViewSummaryList = CoreDataManager.shared.fetchBookViewedSummary()
        print("getAllBookViewSummry - ", bookViewSummaryList.count)
//        print("bookViewSummary")
//        print(bookViewSummary)
    }
    
    func getBookView(for book: BookInfo) -> BookViewedSummary {
        var bookViewSummary: BookViewedSummary = BookViewedSummary(bookname: "", totalRecords: 110, viewedCount: 10)
        print("getBookView - ", bookViewSummaryList.count)
        if bookViewSummaryList.count > 0 {
            let filteredBooks = bookViewSummaryList.filter { $0.bookname == book.title }
            if let firstFilteredBook = filteredBooks.first {
                bookViewSummary = firstFilteredBook
            }
        }
        
        print("getBookView - ", bookViewSummary)
        return bookViewSummary
    }
}

