//
//  PoemListViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import Foundation

class PoemListViewModel: ObservableObject {
    @Published var poems: [Poem] = []

    func fetchPoems(for section: Section) {
        poems = CoreDataManager.shared.fetchPoems(for: section)
    }
}
