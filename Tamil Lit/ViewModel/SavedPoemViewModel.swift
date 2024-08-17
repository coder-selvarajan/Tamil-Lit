//
//  SavedPoemViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 22/07/24.
//

import SwiftUI
import CoreData

class SavedPoemViewModel : ObservableObject {
    @Published var favPoemsByCategory: [String: [Poem]] = [:]
    @Published var favPoemsByDate: [String: [Poem]] = [:]
    @Published var sortedKeys: [String] = []
    
    @Published var favPoems: [Poem] = []
    @Published var favPoemsByBook: [Poem] = []
    
//    func getAllFavPoems() {
//        favPoems = CoreDataManager.shared.fetchAllFavPoems()
//    }
    
    func getRandomPoem() -> Poem? {
        if let randomPoem = CoreDataManager.shared.fetchRandomPoem(excludingBookNames: []) {
            return randomPoem
        }
        
        return nil
    }
    
    func getPoemFromFavPoem(favPoem: Poem) -> Poem? {
        return CoreDataManager.shared.fetchPoemByBookNumber(favPoem.bookname ?? "", Int(favPoem.number))
    }
    
    func getRandomPoem(bookOptions: [BookInfo]) -> Poem? {
        let excludedBookNames: [String] = bookOptions.filter { !$0.selected }.map { $0.title }

        if let randomPoem = CoreDataManager.shared.fetchRandomPoem(excludingBookNames: excludedBookNames) {
            return randomPoem
        }
        
        return nil
    }
    
    func getAllFavPoemsCategoried(bookOptions: [BookInfo]) {
        let bookMgr = BookManager()
        
        let excludedBookNames: [String] = bookOptions.filter { !$0.selected }.map { $0.title }
        
        let poems = CoreDataManager.shared.fetchAllBookmarkedPoems(excludingBookNames: excludedBookNames)
        favPoems = poems
        
        // order by date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium

        let dictByDate = Dictionary(grouping: poems, by: { poem in
            dateFormatter.string(from: poem.timestamp ?? Date())
        })
        favPoemsByDate = dictByDate
        
        
        // order by book
        let dictResults = Dictionary(grouping: poems, by: { $0.bookname ?? "Unknown Book" })
        let bookOrderMapping = bookMgr.books.reduce(into: [String: Int]()) { (dict, book) in
            dict[book.title] = book.order
        }
        
        sortedKeys = dictResults.keys.sorted { (key1, key2) -> Bool in
            let order1 = bookOrderMapping[key1] ?? Int.max
            let order2 = bookOrderMapping[key2] ?? Int.max
            return order1 < order2
        }
        
        let orderedSearchResults = sortedKeys.reduce(into: [String: [Poem]]()) { (dict, key) in
            if let value = dictResults[key] {
                dict[key] = value
            }
        }
        
        favPoemsByCategory = orderedSearchResults
    }
    
    func getAllFavPoemsByBook(_ bookName: String) {
        favPoemsByBook = CoreDataManager.shared.fetchBookmarkedPoemsByBook(for: bookName)
    }
    
    func saveFavPoem(_ favPoem: Poem) -> Bool {
        CoreDataManager.shared.updatePoemBookmarkingStatus(poem: favPoem, status: true)
        
        return true
    }
    
    func removeFavPoem(_ favPoem: Poem) -> Bool {
        CoreDataManager.shared.updatePoemBookmarkingStatus(poem: favPoem, status: false)
        
        return true
    }
    
    func isPoemBookmarked(_ poem: Poem) -> Bool {
        return poem.bookmarked
    }
}
