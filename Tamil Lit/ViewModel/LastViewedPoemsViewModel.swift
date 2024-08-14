//
//  LastViewedPoemsViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 14/08/24.
//

import SwiftUI

class LastViewedPoemsViewModel: ObservableObject {
    @Published var lastFiveViewedPoems: [Poem] = []
    @Published var lastHundredViewedPoems: [Poem] = []
    
    func getLastFiveViewedPoems() {
        lastFiveViewedPoems = CoreDataManager.shared.fetchLastFiveViewedPoems()
    }
    
    func getLastHundredViewedPoems() {
        lastHundredViewedPoems = CoreDataManager.shared.fetchLastHundredViewedPoems()
    }
}
