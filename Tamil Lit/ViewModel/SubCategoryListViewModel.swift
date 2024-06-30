//
//  SubCategoryListViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import Foundation

class SubCategoryListViewModel: ObservableObject {
    @Published var subCategories: [SubCategory] = []

    func fetchSubCategories(for mainCategory: MainCategory) {
        subCategories = CoreDataManager.shared.fetchSubCategories(for: mainCategory)
    }
}
