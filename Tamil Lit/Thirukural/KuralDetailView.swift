//
//  KuralDetailView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

struct KuralDetailView: View {
    let kural: Kural

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10.0) {
                Text("#\(kural.Number)")
                    .fontWeight(Font.Weight.bold)
                    .foregroundStyle(.blue)
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("\(kural.Line1)")
                        .fontWeight(Font.Weight.bold)
                        .foregroundStyle(.indigo)
                    Text("\(kural.Line2)")
                        .fontWeight(Font.Weight.bold)
                        .foregroundStyle(.indigo)
                }
                
                Spacer()
                
                Text("Translation: \(kural.Translation)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Divider().background(.gray)
                
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("Mu. Va:")
                        .font(.callout)
                    Text("\(kural.mv)")
                        .font(.subheadline)
                        .fontWeight(Font.Weight.bold)
                        .foregroundStyle(.purple)
                }
                
                Divider().background(.gray)
                    
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("Salaman Papaya:")
                        .font(.callout)
                    Text("\(kural.sp)")
                        .font(.subheadline)
                        .fontWeight(Font.Weight.bold)
                        .foregroundStyle(.purple)
                }
                Divider().background(.gray)
                
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("Kalainar:")
                        .font(.callout)
                    Text("\(kural.mk)")
                        .font(.subheadline)
                        .fontWeight(Font.Weight.bold)
                        .foregroundStyle(.purple)
                }
                Spacer()
                
            }
            .padding()
        }
        .navigationTitle("Kural Meaning")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    KuralDetailView()
//}
