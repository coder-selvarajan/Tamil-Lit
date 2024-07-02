//
//  CategoryViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 02/07/24.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var mainCategories: [MainCategory] = []
    @Published var subCategories: [SubCategory] = []
    @Published var sections: [Section] = []
    @Published var poems: [Poem] = []

    @Published var selectedMainCategory: MainCategory?
    @Published var selectedSubCategory: SubCategory?
    @Published var selectedSection: Section?
    
    @Published var filteredSubCategories: [SubCategory] = []
    @Published var filteredSections: [Section] = []
    @Published var filteredPoems: [Poem] = []

    func fetchAllData(bookname: String) {
        mainCategories = CoreDataManager.shared.fetchMainCategories(for: bookname)
        subCategories = CoreDataManager.shared.fetchAllSubCategories(for: bookname)
        sections = CoreDataManager.shared.fetchAllSections(for: bookname)
        poems = CoreDataManager.shared.fetchAllPoems(for: bookname)
        
        if let firstMainCategory = mainCategories.first {
            selectMainCategory(firstMainCategory)
        }
    }

    func selectMainCategory(_ mainCategory: MainCategory) {
        selectedMainCategory = mainCategory
        filteredSubCategories = subCategories.filter { $0.mainCategory == mainCategory }
        if let firstSubCategory = filteredSubCategories.first {
            selectSubCategory(firstSubCategory)
        }
    }

    func selectSubCategory(_ subCategory: SubCategory) {
        selectedSubCategory = subCategory
        filteredSections = sections.filter { $0.subCategory == subCategory }
        if let firstSection = filteredSections.first {
            selectSection(firstSection)
        }
    }

    func selectSection(_ section: Section) {
        selectedSection = section
        filteredPoems = poems.filter { $0.section == section }
    }
}
