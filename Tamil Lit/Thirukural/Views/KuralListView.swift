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
                NavigationLink(destination: KuralDetailView(kuralList: kuralList,
                                                            kural: item,
                                                            section: section,
                                                            chapterGroup: chapterGroup,
                                                            chapter: chapter)) {
                    Text("\(item.Number): \(item.Line1) \(item.Line2)")
                }
                .listSectionSeparatorTint(Color.white)
                .listRowBackground(Color.blue.opacity(0.3))
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
