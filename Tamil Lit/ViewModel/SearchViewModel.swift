//
//  SearchViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 19/07/24.
//

import SwiftUI
import CoreData

class SearchViewModel: ObservableObject {
    @Published var searchResults: [String: [Poem]] = [:]
    @Published var sortedKeys: [String] = []
    
    func search(_ searchText: String, bookOptions: [BookInfo], books: [BookInfo]) {
        saveRecentSearch(searchText)
        
        let excludedBookNames: [String] = bookOptions.filter { !$0.selected }.map { $0.title }
        let poems = CoreDataManager.shared.performSearch(searchText: searchText, excludingBookNames: excludedBookNames)
        let dictResults = Dictionary(grouping: poems, by: { $0.bookname ?? "Unknown Book" })
        
        let bookOrderMapping = books.reduce(into: [String: Int]()) { (dict, book) in
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
        
        searchResults = orderedSearchResults
    }
    
    // Saving the search texts in user defaults
    func saveRecentSearch(_ searchText: String) {
        var recentSearches = UserDefaults.standard.stringArray(forKey: "RecentSearches") ?? []
        if recentSearches.contains(searchText) {
            recentSearches.removeAll { $0 == searchText }
        }
        recentSearches.insert(searchText, at: 0)
        if recentSearches.count > 20 { // Limiting to 20 recent searches
            recentSearches.removeLast()
        }
        UserDefaults.standard.set(recentSearches, forKey: "RecentSearches")
    }
    
    // Getting the recent search texts from user defaults
    func getRecentSearch() -> [String] {
        return UserDefaults.standard.stringArray(forKey: "RecentSearches") ?? []
    }
}
