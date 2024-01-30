//
//  KuralDetailView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

struct KuralDetailView: View {
    let kural: Kural
    let chapter: KuralChapter

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10.0) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("#\(kural.Number)")
                        .fontWeight(Font.Weight.bold)
                        .foregroundStyle(.blue)
                    VStack(alignment: .leading, spacing: 2.0) {
                        Text("\(kural.Line1)")
                            .font(.headline)
                            .foregroundStyle(.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(kural.Line2)")
                            .font(.headline)
                            .foregroundStyle(.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(15)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.25))
                .cornerRadius(15)
                
                Spacer()
                
                Text("Translation: \(kural.Translation)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Divider().background(.gray)
                
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("மு.வரதராசன் உரை:")
                        .font(.callout)
                        .foregroundStyle(.indigo)
                    Text("\(kural.mv)")
                        .font(.body)
//                        .fontWeight(Font.Weight.bold)
//                        .foregroundStyle(.purple)
                }
                
                Divider().background(.gray)
                    
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("சாலமன் பாப்பையா உரை:")
                        .font(.callout)
                        .foregroundStyle(.indigo)
                    Text("\(kural.sp)")
                        .font(.body)
//                        .fontWeight(Font.Weight.bold)
//                        .foregroundStyle(.purple)
                }
                Divider().background(.gray)
                
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("கலைஞர் உரை:")
                        .font(.callout)
                        .foregroundStyle(.indigo)
                    Text("\(kural.mk)")
                        .font(.body)
//                        .fontWeight(Font.Weight.bold)
//                        .foregroundStyle(.purple)
                }
                Spacer()
                
            }
            .padding()
        }
        .navigationTitle(chapter.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    KuralDetailView()
//}
