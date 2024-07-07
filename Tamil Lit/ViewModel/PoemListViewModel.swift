//
//  PoemListViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import Foundation

class PoemListViewModel: ObservableObject {
    @Published var poems: [Poem] = []

    func fetchPoemsBySection(_ section: Section) {
        poems = CoreDataManager.shared.fetchPoemsBySection(section)
    }
    
    func fetchPoemsByCategory(_ mainCategory: MainCategory) {
        poems = CoreDataManager.shared.fetchPoemsByCategory(mainCategory)
    }
}
