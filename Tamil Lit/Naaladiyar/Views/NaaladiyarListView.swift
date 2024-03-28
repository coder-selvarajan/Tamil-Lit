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
        List(naaladiyarPoemList ?? [], id: \.self) { poem in
            NavigationLink(destination: NaaladiyarDetailView(poem: poem,
                                                             category: category,
                                                             subCategory: subCategory,
                                                             section: section)) {
                Text("\(poem.number): \(poem.poem)")
            }
        }
        .navigationBarTitle(section.section)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    NaaladiyarListView()
//}
