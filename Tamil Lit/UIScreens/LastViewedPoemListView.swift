//
//  LastViewedPoemListView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 16/08/24.
//

import SwiftUI

struct LastViewedPoemListView: View {
    @EnvironmentObject var bookManager: BookManager
    @StateObject private var vm = LastViewedPoemsViewModel()
    
    func getCategoryDisplay(_ poem: Poem) -> String {
        if let section = poem.sectionname, section != "", !section.starts(with: "பாடல்") {
            return "வகை: " + section
        } else if let subCat = poem.subcategoryname, subCat != "", !subCat.starts(with: "பாடல்") {
            return "வகை: " + subCat
        } else if let mainCat = poem.maincategoryname, mainCat != "", !mainCat.starts(with: "பாடல்") {
            return "வகை: " + mainCat
        }
        
        return ""
    }
    
    var body: some View {
        //Results
        ZStack {
            List {
                ForEach(vm.lastViewedPoemsByDate.keys.sorted().reversed(), id: \.self) { day in
                    SwiftUI.Section(header:
                                        HStack {
                        Spacer()
                        Text(day)
                            .font(.subheadline)
                        
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: size20, height: size20)
                    }) {
                        ForEach(vm.lastViewedPoemsByDate[day] ?? [], id: \.id) { poem in
                            NavigationLink(destination: PoemDetailWrapperView(selectedPoem: poem))
                            {
                                VStack(alignment: .leading) {
                                    Text("\(poem.bookname ?? "") - \(poem.book?.poemType ?? "") \(poem.number)")
                                        .font(.headline)
                                    
                                    if getCategoryDisplay(poem) != "" {
                                        Text(getCategoryDisplay(poem))
                                            .font(.subheadline.bold())
                                    }
                                    
                                    Text("\(poem.poem ?? "")")
                                        .lineLimit(3)
                                }
                                .foregroundStyle(.black)
                                
                            }
                            .listRowBackground(Color.gray.opacity(0.15))
                        }
                    }
                }
                
                /*
                ForEach(vm.lastHundredViewedPoems ?? [], id: \.id) { poem in
                    NavigationLink(destination: PoemDetailWrapperView(selectedPoem: poem))
                    {
                        VStack(alignment: .leading) {
                            Text("\(poem.bookname ?? "") - \(poem.book?.poemType ?? "") \(poem.number)")
                                .font(.headline)
                            
                            if getCategoryDisplay(poem) != "" {
                                Text(getCategoryDisplay(poem))
                                    .font(.subheadline.bold())
                            }
                            
                            Text("\(poem.poem ?? "")")
                                .lineLimit(3)
                        }
                        .foregroundStyle(.black)
                        
                    }
                    .listRowBackground(Color.gray.opacity(0.15))
                } // foreach
                */
            }
            .modifier(ListBackgroundModifier())
            .listStyle(.insetGrouped)
            .background(Color.clear)
        }
//        .navigationTitle(Text("Recently viewed poems"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            vm.getLastHundredViewedPoems()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: size20)
                        .padding(.trailing, size10)
                    Text("Recently viewed poems")
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding(0)
            }
        } // toolbar
        .customFontScaling()
    }
}
