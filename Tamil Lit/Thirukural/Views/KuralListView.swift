//
//  KuralListView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

struct KuralListView: View {
    let kuralList: [Kural]?
    let chapter: KuralChapter
    
    var body: some View {
        List(kuralList ?? []) { item in
            NavigationLink(destination: KuralDetailView(kural: item, chapter: chapter)) {
                Text("\(item.Number): \(item.Line1)")
            }
        }
        .navigationBarTitle(chapter.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    KuralListView(kuralData: [Kural])
//}
