//
//  AthichudiViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import Foundation

class AthichudiViewModel {
    
    func loadAthichudiData() -> [Athichudi] {
        guard let url = Bundle.main.url(forResource: "athichudi", withExtension: "json") else {
            fatalError("Failed to locate file in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file from bundle.")
        }
        
        let decoder = JSONDecoder()
        let decodedData = try! decoder.decode(AthichudiData.self, from: data)
        
        return decodedData.athichudi
    }
    
}
