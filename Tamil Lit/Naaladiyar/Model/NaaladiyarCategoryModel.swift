//
//  NaaladiyarCategoryModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 24/03/24.
//

import Foundation

// Define the top-level container
struct NaaladiyarCategoryRoot: Codable, Hashable {
    let categories: [NaaladiyarCategory]
}

// Define the category
struct NaaladiyarCategory: Identifiable, Codable, Hashable {
    var id: Int { number }
    let number: Int
    let category: String
    let subcategories: [NaaladiyarSubcategory]
}

// Define the subcategory
struct NaaladiyarSubcategory: Identifiable, Codable, Hashable {
    var id: Int { number }
    let number: Int
    let subcategory: String
    let sections: [NaaladiyarSection]
}

// Define the section
struct NaaladiyarSection: Identifiable, Codable, Hashable {
    var id: Int { number }
    let number: Int
    let section: String
    let start: Int
    let end: Int
}
