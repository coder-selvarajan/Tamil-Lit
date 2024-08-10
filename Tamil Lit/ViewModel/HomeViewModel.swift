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
        
    func getAllBookViewSummry() {
        bookViewSummaryList = CoreDataManager.shared.fetchBookViewedSummary()
    }
    
    func getBookView(for book: BookInfo) -> BookViewedSummary {
        var bookViewSummary: BookViewedSummary = BookViewedSummary(bookname: "", totalRecords: 110, viewedCount: 10)
        if bookViewSummaryList.count > 0 {
            let filteredBooks = bookViewSummaryList.filter { $0.bookname == book.title }
            if let firstFilteredBook = filteredBooks.first {
                bookViewSummary = firstFilteredBook
            }
        }
        
        return bookViewSummary
    }
}

