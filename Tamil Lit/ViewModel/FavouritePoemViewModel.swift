//
//  FavouritePoemViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 22/07/24.
//

import SwiftUI
import CoreData

class FavouritePoemViewModel : ObservableObject {
    @Published var favPoems: [FavouritePoem] = []
    @Published var favPoemsByBook: [FavouritePoem] = []
    
    func getAllFavPoems() {
        favPoems = CoreDataManager.shared.fetchAllFavPoems()
    }
    
    func getAllFavPoemsByBook(_ bookName: String) {
        favPoemsByBook = CoreDataManager.shared.fetchFavPoemsByBook(for: bookName)
    }
    
    func saveFavPoem(_ favPoem: Poem) {
        CoreDataManager.shared.saveFavPoem(bookname: favPoem.bookname!,
                                           number: favPoem.number,
                                           poem: favPoem.poem!,
                                           title: favPoem.title!,
                                           mainCategory: favPoem.maincategoryname ?? "",
                                           subCategory: favPoem.subcategoryname ?? "",
                                           section: favPoem.sectionname ?? "")
        
    }
}
