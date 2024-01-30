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
        ScrollView {
            VStack(alignment: .leading, spacing: 10.0) {
                HStack(alignment: .top, spacing: 10.0) {
                    Text("\(athichudi.number). \(athichudi.poem)")
                        .font(.headline)
                        .foregroundStyle(.teal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(15)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.25))
                .cornerRadius(15)
                
                Spacer()
                
                Text("Translation: \(athichudi.translation ?? "")")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Divider().background(.gray)
                
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("Meaning: ")
                        .font(.callout)
                        .foregroundStyle(.teal)
                    Text("\(athichudi.meaning ?? "")")
                        .font(.body)
                }
                
                Divider().background(.gray)
                    
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
        .navigationTitle("ஆத்தி சூடி")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    AthichudiDetailView()
//}
