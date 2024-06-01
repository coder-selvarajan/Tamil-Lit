//
//  KuralListView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

struct KuralListView: View {
    let kuralList: [Kural]?
    let section: KuralSection
    let chapterGroup: KuralChapterGroup
    let chapter: KuralChapter
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.2).ignoresSafeArea()
            
            List(kuralList ?? []) { item in
                NavigationLink(destination: KuralDetailView(kural: item, section: section, chapterGroup: chapterGroup, chapter: chapter)) {
                    Text("\(item.Number): \(item.Line1)")
                }
                .listRowBackground(Color.white.opacity(0.7))
            }
            .scrollContentBackground(Visibility.hidden)
        }
        .navigationBarTitle(chapter.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    KuralListView(kuralData: [Kural])
//}
