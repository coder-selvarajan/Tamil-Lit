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
    
    func search(_ searchText: String) {
        saveRecentSearch(searchText)
        
        let poems = CoreDataManager.shared.performSearch(searchText: searchText)
        searchResults = Dictionary(grouping: poems, by: { $0.bookname ?? "Unknown Book" })
    }
    
    func getRandomPoem() -> Poem? {
        return CoreDataManager.shared.fetchRandomPoem()
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
