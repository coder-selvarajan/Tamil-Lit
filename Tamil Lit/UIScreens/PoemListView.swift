//
//  PoemListView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI

struct PoemListView: View {
    let book: BookInfo
    
    var mainCategory: MainCategory?
    var subCategory: SubCategory?
    var section: Section?
    
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var themeManager: ThemeManager
    
    @StateObject private var viewModel = PoemListViewModel()
    
    @State private var showBookDetails: Bool = false
    
    @State private var showAlert: Bool = false
    
    func getTitle() -> String {
        if let title = section?.title {
            return title
        }
        
        if let title = subCategory?.title {
            return title
        }
        
        if let title = mainCategory?.title {
            return title
        }
        
        return ""
    }
    
    func getCategoryText() -> String {
        if section != nil {
            return "\(mainCategory?.title ?? "") › \(subCategory?.title ?? "") › \(section?.title ?? "")"
        } else if subCategory != nil {
            return "\(mainCategory?.title ?? "") › \(subCategory?.title ?? "")"
        } else {
            return "வகை: \(mainCategory?.title ?? "")"
        }
    }
    
    var body: some View {
        ZStack {
            if themeManager.selectedTheme == .colorful {
                book.color.opacity(0.2).ignoresSafeArea()
            }
            
            VStack {
                
                List {
                    SwiftUI.Section(header: Text("\(getCategoryText())").font(.headline).foregroundStyle(.primary).padding(.bottom, 10)) {
                        ForEach(viewModel.poems, id:\.self) { poem in
                            NavigationLink(destination: PoemDetailView(book: book,
                                                                       poems: viewModel.poems,
                                                                       selectedPoem: poem)
                                            .environmentObject(navigationManager)) {
                                Text("\(poem.number). \(poem.poem ?? "No Poem")")
                            }
                                                                       .listRowBackground(themeManager.selectedTheme == ThemeSelection.colorful ? book.color.opacity(0.2) : .gray.opacity(0.2))
                        }
                    }
                }
                .modifier(ListBackgroundModifier())
                .listStyle(.insetGrouped)
                .background(Color.clear)
            }
        }
        .navigationTitle(Text("Poem List"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if section != nil {
                viewModel.fetchPoemsBySection(section!)
            } else if mainCategory != nil {
                viewModel.fetchPoemsByCategory(mainCategory!)
            }
        }
        .sheet(isPresented: $showBookDetails) {
            VStack {
                Text("Showing the alert")
            }
            
//            BookDetailsView(bookName: book.title)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    if section == nil {
                        Spacer()
                    }
                    
                    Image(book.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size30)
                        .padding(.trailing, size10)
                    Text(book.title)
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding(0)
            }
            
            ToolbarItem {
                Button {
                    navigationManager.isRootActive = false
                    navigationManager.activeBook.keys.forEach { navigationManager.activeBook[$0] = false }
                } label: {
                    HStack(alignment: .top, spacing: 5) {
                        Image(systemName: "house")
                            .font(.caption2)
                        Text("Home")
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color("TextColor"))
                    .padding(.vertical, 5)
                    .padding(.horizontal, size10)
                    .background(themeManager.selectedTheme == .colorful ? book.color.opacity(0.3) : .gray.opacity(0.2))
                    .cornerRadius(8)
                }
            }
        } // toolbar
        .customFontScaling()
    }
}


//#Preview {
//    PoemListView()
//}

