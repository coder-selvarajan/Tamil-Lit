//
//  PoemDetailViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 10/08/24.
//

import CoreData

class PoemDetailsViewModel: ObservableObject {
    @Published var poemsByCategoryNames: [Poem]?
    
    func updatePoemViewedStatus(for poem: Poem) {
        CoreDataManager.shared.updatePoemViewedStatus(for: poem)
    }
    
    func getPoemsByCategory(bookName: String, mainCategory: String, subCategory: String, section: String) {
        poemsByCategoryNames = CoreDataManager.shared.fetchPoemsByBookandCategoryNames(bookName: bookName,
                                                                mainCategory: mainCategory,
                                                                subCategory: subCategory, 
                                                                section: section)
    }
}
