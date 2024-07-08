//
//  PoemListWithCategoryViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 08/07/24.
//

import Foundation

class PoemListWithCategoryViewModel: ObservableObject {
    @Published var categories: [MainCategory] = []
    @Published var selectedCategory: MainCategory?
    @Published var poems: [Poem] = []
    
//    init(book: String) {
//        fetchCateoriesByBook(book)
//        fetchPoemsByBook(book)
//    }
    
    func fetchCateoriesByBook(_ bookName: String) {
        categories = CoreDataManager.shared.fetchMainCategories(for: bookName)
        if categories.count > 0 {
            selectedCategory = categories.first
        }
    }
    
//    func fetchPoemsByCategory() {
//        if let category = selectedCategory {
//            poems = CoreDataManager.shared.fetchPoemsByCategory(category)
//        } else {
//            poems = []
//        }
//    }
    
    func fetchPoemsByBook(_ bookName: String) {
        poems = CoreDataManager.shared.fetchPoemsByBook(bookName)
    }
    
    func fetchPoemsByCategory(_ categoryTitle: String) -> [Poem] {
        let filteredPoems = poems.filter { $0.mainCategory?.title == categoryTitle }
        
        return filteredPoems
    }
    
}
