//
//  ExplanationListViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import Foundation

class ExplanationListViewModel: ObservableObject {
    @Published var explanations: [Explanation] = []

    func fetchExplanations(for poem: Poem) {
        explanations = CoreDataManager.shared.fetchExplanations(for: poem)
    }
    
    func getExplanations(for poem: Poem) -> [Explanation] {
        return CoreDataManager.shared.fetchExplanations(for: poem)
    }
}
