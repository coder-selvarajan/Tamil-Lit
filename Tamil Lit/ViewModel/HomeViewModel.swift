//
//  HomeViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 19/07/24.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    @Published var randomPoem: Poem?
    
    func getRandomPoem() {
        randomPoem = CoreDataManager.shared.fetchRandomPoem()
    }
}
