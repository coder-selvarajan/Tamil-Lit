//
//  MainCategoryListViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import Foundation

class MainCategoryListViewModel: ObservableObject {
    @Published var mainCategories: [MainCategory] = []

    func fetchMainCategories() {
        mainCategories = CoreDataManager.shared.fetchMainCategories()
    }
    
    
}
