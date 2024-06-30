//
//  SectionListViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import Foundation

class SectionListViewModel: ObservableObject {
    @Published var sections: [Section] = []
    
    func fetchSections(for subCategory: SubCategory) {
        sections = CoreDataManager.shared.fetchSections(for: subCategory)
    }
}
