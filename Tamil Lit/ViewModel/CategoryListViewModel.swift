//
//  CategoryListViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import Foundation

class CategoryListViewModel: ObservableObject {
    @Published var mainCategories: [MainCategory] = []
    @Published var selectedMainCategory: MainCategory?
    @Published var subCategories: [SubCategory] = []
    @Published var selectedSubCategory: SubCategory?
    @Published var sections: [Section] = []

    func fetchMainCategories() {
        mainCategories = CoreDataManager.shared.fetchMainCategories()
        if let firstMainCategory = mainCategories.first {
            selectMainCategory(firstMainCategory)
        }
    }

    func fetchSubCategories(for mainCategory: MainCategory) {
        subCategories = CoreDataManager.shared.fetchSubCategories(for: mainCategory)
        if let firstSubCategory = subCategories.first {
            selectSubCategory(firstSubCategory)
        }
    }

    func fetchSections(for subCategory: SubCategory) {
        sections = CoreDataManager.shared.fetchSections(for: subCategory)
        
    }

    func selectMainCategory(_ mainCategory: MainCategory) {
        selectedMainCategory = mainCategory
        fetchSubCategories(for: mainCategory)
//        selectedSubCategory = nil
//        sections = []
    }

    func selectSubCategory(_ subCategory: SubCategory) {
        selectedSubCategory = subCategory
        fetchSections(for: subCategory)
    }
}
