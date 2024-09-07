//
//  PoemListWithCategoryView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 08/07/24.
//

import SwiftUI

struct PoemListWithCategoryView: View {
    @AppStorage("showBookInfoPopup") private var showBookInfoPopup: Bool = false
    @AppStorage("bookInfoPopupCounter") private var bookInfoPopupCounter: Int = 0
    
    let book: BookInfo
    
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var themeManager: ThemeManager
    
    @StateObject var viewModel = PoemListWithCategoryViewModel()
    @State private var selectedCategoryId: UUID?
    @State private var highlightedCategoryId: UUID?
    @State private var showBookInfo: Bool = false
    
    func getShortTitle(_ category: MainCategory) -> String {
        if let title = category.title, title.starts(with: "பாடல்கள்") {
            return String(describing: category.start) + " - " + String(describing: category.end)
        }
        
        return category.title ?? ""
    }
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("வகைகள்: ")
                        .foregroundStyle(Color("TextColor").opacity(0.8))
                        .font(.footnote.bold())
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: size10) {
                            ForEach(viewModel.categories, id: \.id) { category in
                                Button {
                                    viewModel.selectedCategory = category
                                    highlightedCategoryId = category.id
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        withAnimation {
                                            highlightedCategoryId = nil
                                        }
                                    }
                                    
                                    withAnimation {
                                        selectedCategoryId = category.id
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        selectedCategoryId = nil
                                    }
                                } label: {
                                    if themeManager.selectedTheme == .colorful { // for colorful theme
                                        if #available(iOS 16.0, *) {
                                            Text(getShortTitle(category))
                                                .font(.subheadline)
                                                .padding(.horizontal, size10)
                                                .padding(.vertical, size10)
                                                .foregroundColor(highlightedCategoryId == category.id ? .white : .black)
                                                .background(highlightedCategoryId == category.id
                                                            ? book.color.opacity(0.7) : .white.opacity(0.7))
                                                .cornerRadius(8.0)
                                        } else { // iOS 15
                                            Text(getShortTitle(category))
                                                .font(.subheadline)
                                                .padding(.horizontal, size10)
                                                .padding(.vertical, size10)
                                                .foregroundColor(highlightedCategoryId == category.id ? .white : .black)
                                                .background(highlightedCategoryId == category.id
                                                            ? book.color.opacity(0.7)
                                                            : book.color.opacity(0.2))
                                                .cornerRadius(8.0)
                                        }
                                    } else { // for light and dark themes
                                        Text(getShortTitle(category))
                                            .font(.subheadline)
                                            .padding(.horizontal, size10)
                                            .padding(.vertical, size10)
                                            .foregroundStyle(Color("TextColor"))
                                            .background(.gray.opacity(0.2))
                                            .cornerRadius(8.0)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, size10)
                    }
                } // VStack
                .padding(.top)
                
//                Divider().padding(.bottom, size10).padding(.top, 0)
                
                VStack(alignment: .leading) {
                    ScrollViewReader { proxy in
                        List {
                            ForEach(viewModel.categories, id:\.id) { category in
                                SwiftUI.Section(header: EmptyView().frame(height: 0).id(category.id)) {
                                    SwiftUI.Section(header: Text(category.title ?? "")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding(.leading, 0)
                                        .padding(.top, 0)) {
                                            // fetch poems by category and display in a section
                                            ForEach(viewModel.fetchPoemsByCategory(category.title ?? ""), id: \.id) { poem in
                                                NavigationLink(destination: 
                                                PoemDetailView(book: book,
                                                               poems: viewModel.fetchPoemsByCategory(category.title ?? ""),
                                                               selectedPoem: poem)) {
                                                    if let poemText = poem.poem {
                                                        Text(poemText)
                                                    }
                                                }
                                            }
                                        } //Section2
                                } //Section1
                                .listRowBackground(themeManager.selectedTheme == ThemeSelection.colorful ? book.color.opacity(0.2) : .gray.opacity(0.1))
                            }
                            .onChange(of: selectedCategoryId) { id in
                                if let id = id {
                                    withAnimation(.spring()) {
                                        proxy.scrollTo(id, anchor: .top)
                                    }
                                }
                            }
                        } // List
                        .modifier(ListBackgroundModifier())
                        .listStyle(.insetGrouped)
                        .background(Color.clear)
                        .padding(.top, -5)
                    } //ScrollViewReader
                }
            } // VStack
        }
        .navigationBarBackButtonHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("\(book.title)")
        .accessibilityLabel("Category & Poem List View")
        .onAppear {
            if showBookInfoPopup {
                showBookInfo = true
                showBookInfoPopup = false
                bookInfoPopupCounter += 1
            }
            
            viewModel.fetchCateoriesByBook(book.title)
            viewModel.fetchPoemsByBook(book.title)
        }
        .sheet(isPresented: $showBookInfo) {
            BookDetailsView(bookName: book.title)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    // Search Bar
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
                    showBookInfo = true
                } label: {
                    HStack {
                        Image(systemName: "book")
                            .font(.footnote)
                            .foregroundStyle(Color("TextColor"))
                        
                        Text("Info")
                            .font(.subheadline.bold())
                            .foregroundStyle(Color("TextColor"))
                    }
                    .padding(.vertical, size10 * 0.7)
                    .padding(.horizontal, size10)
                    .background(themeManager.selectedTheme == .colorful ? book.color.opacity(0.3) : .gray.opacity(0.2))
                    .cornerRadius(8)
                }
            }
        }
        .customFontScaling()
    }
}

//#Preview {
//    PoemListWithCategoryView()
//}
