//
//  SinglePoemDetailViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 19/07/24.
//

import SwiftUI
import CoreData

class SinglePoemDetailViewModel: ObservableObject {
    
    func getRandomPoem() -> Poem? {
        return  CoreDataManager.shared.fetchRandomPoem()
    }
}
