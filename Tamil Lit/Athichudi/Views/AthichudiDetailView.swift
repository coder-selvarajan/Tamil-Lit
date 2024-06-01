//
//  AathicudiDetailView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

struct AthichudiDetailView: View {
    let athichudi: Athichudi

    var body: some View {
        ZStack {
            Color.teal.opacity(0.2).ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10.0) {
                    HStack(alignment: .top, spacing: 10.0) {
                        Text("\(athichudi.number). \(athichudi.poem)")
                            .font(.headline)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .background(.teal.opacity(0.5))
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    Text("Translation: \(athichudi.translation ?? "")")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.80))
                    
                    Spacer()
                    
                    Divider().background(.black.opacity(0.7))
                    
                    VStack(alignment: .leading, spacing: 2.0) {
                        Text("Meaning: ")
                            .font(.callout)
                            .foregroundStyle(.teal)
                        Text("\(athichudi.meaning ?? "")")
                            .font(.body)
                    }
                    
                    Divider().background(.black.opacity(0.7))
                    
                    VStack(alignment: .leading, spacing: 2.0) {
                        Text("Paraphrase:")
                            .font(.callout)
                            .foregroundStyle(.teal)
                        Text("\(athichudi.paraphrase ?? "")")
                            .font(.body)
                        
                    }
                    
                    Spacer()
                    
                }
                .padding()
            }
        }
        .navigationTitle("ஆத்தி சூடி")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    AthichudiDetailView()
//}
