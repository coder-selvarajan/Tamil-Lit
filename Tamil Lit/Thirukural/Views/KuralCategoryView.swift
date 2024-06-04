//
//  KuralCategoryView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/01/24.
//

import SwiftUI

struct KuralCategoryView: View {
    @State var kuralList: [Kural]
    @State var sections: [KuralSection]
    @State var selSection: KuralSection?
    @State var selChapterGroup: KuralChapterGroup?
    @State var selChapter: KuralChapter?
    
    init(sections: [KuralSection], kuralList: [Kural]) {
        self.kuralList = kuralList
        self.sections = sections
    }
    
    func updateSection(section: KuralSection) {
        self.selSection = section
        if let chapterGroup = section.chapterGroup.detail.first {
            updateChapterGroup(chapterGroup: chapterGroup)
        }
    }
    
    func updateChapterGroup(chapterGroup: KuralChapterGroup) {
        self.selChapterGroup = chapterGroup
        if let chapter = chapterGroup.chapters.detail.first {
            updateChapter(chapter: chapter)
        }
    }
    
    func updateChapter(chapter: KuralChapter) {
        self.selChapter = chapter
    }
    
    func filterKuralByChapter(chapter: KuralChapter) -> [Kural] {
        let filteredKurals = kuralList.filter { $0.Number >= chapter.start && $0.Number <= chapter.end }
        return filteredKurals
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("பால்:")
                    .foregroundStyle(.black.opacity(0.8))
                    .font(.caption)
                    .fontWeight(.bold)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(sections) { section in
                            Text("\(section.name)")
                                .padding(10)
                                .font(.subheadline)
                                .foregroundColor(selSection?.name == section.name ? .white : .black)
                                .background(selSection?.name == section.name ? .blue.opacity(0.8) : .white)
                                .cornerRadius(10.0)
                                .onTapGesture {
                                    updateSection(section: section)
                                }
                            
                        }
                    }
                }
            }
            .padding(.bottom, 10)
            Divider()
            
            VStack(alignment: .leading) {
                Text("இயல்:")
                    .foregroundStyle(.black.opacity(0.8))
                    .font(.caption)
                    .fontWeight(.bold)
                WrapView(data: selSection?.chapterGroup.detail ?? [], content: { chapterGroup in
                    Button(action: {}) {
                        Text(chapterGroup.name)
                            .padding(10)
                            .font(.subheadline)
                            .foregroundColor(selChapterGroup?.name == chapterGroup.name ? .white : .black)
                            .background(selChapterGroup?.name == chapterGroup.name ? .blue.opacity(0.8) : .white)
                            .cornerRadius(10.0)
                            .onTapGesture {
                                updateChapterGroup(chapterGroup: chapterGroup)
                            }
                    }
                })
            }
            .padding(.bottom, 10)
            Divider()
            
            VStack(alignment: .leading) {
                Text("அதிகாரம்:")
                    .foregroundStyle(.black.opacity(0.8))
                    .font(.caption)
                    .fontWeight(.bold)
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(selChapterGroup?.chapters.detail ?? [], id: \.self) { chapter in
                            NavigationLink(destination: KuralListView(kuralList: filterKuralByChapter(chapter: chapter), section: selSection!, chapterGroup: selChapterGroup!, chapter: chapter)) {
                                HStack {
                                    Text("\(chapter.name)")
                                        .padding(.vertical, 10)
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                            }
                            Divider()
                        }
                    }
                }
            }
            
            VStack{
                Text(" ")
            }.frame(height: 50.0)
        }
        .padding(20)
        .navigationBarTitle("திருக்குறள்")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if selSection == nil {
                if let firstSection = sections.first {
                    updateSection(section: firstSection)
                }
            }
        }
    }
}

//#Preview {
//    KuralCategoryView()
//}
