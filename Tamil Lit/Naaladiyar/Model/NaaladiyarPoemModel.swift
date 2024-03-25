//
//  NaaladiyarPoemModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 24/03/24.
//

import Foundation

// Define the root of the JSON structure
struct NaaladiyarPoemData: Codable {
    let about: AboutNaaladiyar
    let poems: [NaaladiyarPoem]
    
    // Use coding keys to map the "About" and "Poem" sections
    enum CodingKeys: String, CodingKey {
        case about = "About"
        case poems = "Poems"
    }
}

// Define the About section model
struct AboutNaaladiyar: Codable {
    let description: String
    let poem: String
    let meaning: String
    
    // Since "Description" and "Poem" are Swift keywords, use coding keys to map them
    enum CodingKeys: String, CodingKey {
        case description = "Description"
        case poem = "Poem"
        case meaning = "Meaning"
    }
}

// Define the Poem model
struct NaaladiyarPoem: Codable {
    let number: Int
    let category: String
    let subCategory: String
    let section: String
    let poem: String
    let meaning: String
    
    // Use coding keys to map JSON keys to Swift property names, especially if they don't match exactly
    enum CodingKeys: String, CodingKey {
        case number = "Number"
        case category = "Category" // Note: There's a typo in the JSON key, it should be "Category"
        case subCategory = "SubCategory" // Note: There's a typo in the JSON key, it should be "SubCategory"
        case section = "Section"
        case poem = "Poem"
        case meaning = "Meaning"
    }
}


