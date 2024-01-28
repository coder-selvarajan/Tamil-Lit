//
//  HomeView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        // Assuming jsonData is your JSON data
        let decoder = JSONDecoder()
        let decodedData = try! decoder.decode(KuralData.self, from: loadKuralData())
        KuralListView(kuralData: decodedData.kural)
    }
    
    func loadKuralData() -> Data {
        guard let url = Bundle.main.url(forResource: "thirukkural", withExtension: "json") else {
            fatalError("Failed to locate file in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file from bundle.")
        }
        
        return data
    }
}

#Preview {
    HomeView()
}
