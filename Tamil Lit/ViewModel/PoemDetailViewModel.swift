//
//  PoemDetailViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 10/08/24.
//

import CoreData

class PoemDetailsViewModel: ObservableObject {
    func updatePoemViewedStatus(for poem: Poem) {
        CoreDataManager.shared.updatePoemViewedStatus(for: poem)
    }
}
