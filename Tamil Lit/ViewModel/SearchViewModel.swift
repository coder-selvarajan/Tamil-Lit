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
        let poems = CoreDataManager.shared.performSearch(searchText: searchText)
        searchResults = Dictionary(grouping: poems, by: { $0.bookname ?? "Unknown Book" })
    }
    
    func getRandomPoem() -> Poem? {
        return CoreDataManager.shared.fetchRandomPoem()
    }
}
