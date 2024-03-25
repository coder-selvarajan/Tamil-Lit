//
//  NaaladiyarViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 24/03/24.
//

import Foundation

class NaaladiyarViewModel {
//    func loadNaaladiyarData() -> [NaaladiyarPoem] {
//        guard let url = Bundle.main.url(forResource: "naaladiyar", withExtension: "json") else {
//            fatalError("Failed to locate file in bundle.")
//        }
//        
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Failed to load file from bundle.")
//        }
//        
//        let decoder = JSONDecoder()
//        let decodedData = try! decoder.decode(NaaladiyarPoemData.self, from: data)
//        
//        return decodedData.poems
//    }
    
    func loadNaaladiyarCategoryData() -> [NaaladiyarCategory] {
        
        guard let url = Bundle.main.url(forResource: "naaladiyar-category", withExtension: "json") else {
            fatalError("Failed to locate file in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file from bundle.")
        }
        
        let decoder = JSONDecoder()
        let naaladiyarCategory = try! decoder.decode(NaaladiyarCategoryRoot.self, from: data)
        
        return naaladiyarCategory.categories
    }
}
