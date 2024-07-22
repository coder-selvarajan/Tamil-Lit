//
//  BookDetailsViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 22/07/24.
//

import SwiftUI
import CoreData

class BookDetailsViewModel: ObservableObject {
    @Published var book: Book?
    
    func getBookInfo(bookName: String) {
        if let bookByName = CoreDataManager.shared.fetchBook(for: bookName) {
            book = bookByName
        }
    }
}
