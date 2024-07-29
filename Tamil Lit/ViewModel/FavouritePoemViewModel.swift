//
//  FavouritePoemViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 22/07/24.
//

import SwiftUI
import CoreData

class FavouritePoemViewModel : ObservableObject {
    @Published var favPoemsByCategory: [String: [FavouritePoem]] = [:]
    @Published var favPoemsByDate: [String: [FavouritePoem]] = [:]
    @Published var sortedKeys: [String] = []
    
    @Published var favPoems: [FavouritePoem] = []
    @Published var favPoemsByBook: [FavouritePoem] = []
    
//    func getAllFavPoems() {
//        favPoems = CoreDataManager.shared.fetchAllFavPoems()
//    }
    
    func getRandomPoem() -> Poem? {
        if let randomPoem = CoreDataManager.shared.fetchRandomPoem(excludingBookNames: []) {
            return randomPoem
        }
        
        return nil
    }
    
    func getPoemFromFavPoem(favPoem: FavouritePoem) -> Poem? {
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
        let excludedBookNames: [String] = bookOptions.filter { !$0.selected }.map { $0.title }
        
        let poems = CoreDataManager.shared.fetchAllFavPoems(excludingBookNames: excludedBookNames)
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
        let bookOrderMapping = _books.reduce(into: [String: Int]()) { (dict, book) in
            dict[book.title] = book.order
        }
        
        sortedKeys = dictResults.keys.sorted { (key1, key2) -> Bool in
            let order1 = bookOrderMapping[key1] ?? Int.max
            let order2 = bookOrderMapping[key2] ?? Int.max
            return order1 < order2
        }
        
        let orderedSearchResults = sortedKeys.reduce(into: [String: [FavouritePoem]]()) { (dict, key) in
            if let value = dictResults[key] {
                dict[key] = value
            }
        }
        
        favPoemsByCategory = orderedSearchResults
    }
    
    func getAllFavPoemsByBook(_ bookName: String) {
        favPoemsByBook = CoreDataManager.shared.fetchFavPoemsByBook(for: bookName)
    }
    
    func saveFavPoem(_ favPoem: Poem) -> Bool {
        return CoreDataManager.shared.saveFavPoem(bookname: favPoem.bookname!,
                                           number: favPoem.number,
                                           poem: favPoem.poem!,
                                           title: favPoem.title!,
                                           mainCategory: favPoem.maincategoryname ?? "",
                                           subCategory: favPoem.subcategoryname ?? "",
                                           section: favPoem.sectionname ?? "")
    }
    
    func removeFavPoem(_ favPoem: Poem) -> Bool {
        return CoreDataManager.shared.removeFavPoem(bookname: favPoem.bookname!, number: favPoem.number)
    }
    
    func isPoemBookmarked(_ poem: Poem) -> Bool {
        return CoreDataManager.shared.isPoemBookmarked(bookname: poem.bookname ?? "", 
                                                       number: Int(poem.number))
    }
}
