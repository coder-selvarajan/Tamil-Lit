//
//  SinglePoemDetailViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 19/07/24.
//

import SwiftUI
import CoreData

class RandomPoemViewModel: ObservableObject {
//    func getRandomPoem() -> Poem? {
//        return  CoreDataManager.shared.fetchRandomPoem()
//    }
    
    func getRandomPoem(bookOptions: [BookInfo]) -> Poem? {
        let excludedBookNames: [String] = bookOptions.filter { !$0.selected }.map { $0.title }

        if let randomPoem = CoreDataManager.shared.fetchRandomPoem(excludingBookNames: excludedBookNames) {
            return randomPoem
        }
        
        return nil
    }
}
