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
                        .foregroundStyle(.white)
                    VStack(alignment: .leading, spacing: 2.0) {
                        Text("\(kural.Line1)")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(kural.Line2)")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(15)
                .frame(maxWidth: .infinity)
//                .background(.gray.opacity(0.15))
                .background(.blue.opacity(0.95))
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
                        .foregroundStyle(.blue)
                    Text("\(kural.mv)")
                        .font(.body)
                }
                
                Divider().background(.gray)
                    
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("சாலமன் பாப்பையா உரை:")
                        .font(.callout)
                        .foregroundStyle(.blue)
                    Text("\(kural.sp)")
                        .font(.body)
                }
                Divider().background(.gray)
                
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("கலைஞர் உரை:")
                        .font(.callout)
                        .foregroundStyle(.blue)
                    Text("\(kural.mk)")
                        .font(.body)
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
