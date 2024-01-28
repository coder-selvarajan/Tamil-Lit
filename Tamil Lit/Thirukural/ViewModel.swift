//
//  ViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import Foundation

class ThirukuralViewModel {
    func loadKuralData() -> [Kural] {
        guard let url = Bundle.main.url(forResource: "thirukkural", withExtension: "json") else {
            fatalError("Failed to locate file in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file from bundle.")
        }
        
        let decoder = JSONDecoder()
        let decodedData = try! decoder.decode(KuralData.self, from: data)
        
        return decodedData.kural
    }
}
