//
//  LastViewedPoemsViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 14/08/24.
//

import SwiftUI

class LastViewedPoemsViewModel: ObservableObject {
    @Published var lastFiveViewedPoems: [Poem]?
    @Published var lastHundredViewedPoems: [Poem]?
    @Published var lastViewedPoemsByDate: [String: [Poem]] = [:]
    
    func getLastThreeViewedPoems() {
        lastFiveViewedPoems = CoreDataManager.shared.fetchLastThreeViewedPoems()
        
        print("\(String(describing: lastFiveViewedPoems?.count)) poems fetched")
    }
    
    func getLastHundredViewedPoems() {
        lastHundredViewedPoems = CoreDataManager.shared.fetchLastHundredViewedPoems()
        
        guard let poems = lastHundredViewedPoems else {
            lastViewedPoemsByDate = [:]
            return
        }
        
        // Order by date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let dictByDate = Dictionary(grouping: poems, by: { poem in
            dateFormatter.string(from: poem.lastUpdated ?? Date())
        })
        
        lastViewedPoemsByDate = dictByDate
    }
}
