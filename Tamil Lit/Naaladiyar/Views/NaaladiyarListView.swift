//
//  NaaladiyarListView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 24/03/24.
//

import SwiftUI

struct NaaladiyarListView: View {
    var naaladiyarPoemList: [NaaladiyarPoem]?
    let category: NaaladiyarCategory
    let subCategory: NaaladiyarSubcategory
    let section: NaaladiyarSection
    
    var body: some View {
        ZStack {
            Color.indigo.opacity(0.2).ignoresSafeArea()
            
            List(naaladiyarPoemList ?? [], id: \.self) { poem in
                NavigationLink(destination: NaaladiyarDetailView(poem: poem,
                                                                 category: category,
                                                                 subCategory: subCategory,
                                                                 section: section)) {
                    Text("\(poem.number): \(poem.poem)")
                }
                .listRowBackground(Color.white.opacity(0.7))
            }
            .scrollContentBackground(Visibility.hidden)
        }
        .navigationBarTitle(section.section)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    NaaladiyarListView()
//}
