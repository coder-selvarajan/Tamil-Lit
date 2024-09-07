//
//  SingleCategoryView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 06/07/24.
//

import SwiftUI

struct SingleCategoryView: View {
    @AppStorage("showBookInfoPopup") private var showBookInfoPopup: Bool = false
    @AppStorage("bookInfoPopupCounter") private var bookInfoPopupCounter: Int = 0
    
    @EnvironmentObject var themeManager: ThemeManager
    
    let book: BookInfo
    
    @StateObject private var viewModel = SingleCategoryViewModel()
    @State private var showBookInfo: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                SwiftUI.Section(header: Text("வகைகள்: ").fontWeight(.bold).foregroundStyle(.black)) {
                    ForEach(viewModel.categories, id:\.self) { category in
                        if let title = category.title {
                            NavigationLink(destination:
                                            PoemListView(book: book,
                                                         mainCategory: category)) {
                                Text(title)
                            }
                        }
                    }
                }
                .listRowBackground(themeManager.selectedTheme == ThemeSelection.colorful ? book.color.opacity(0.2) : .gray.opacity(0.1))
            }
            .modifier(ListBackgroundModifier())
            .listStyle(.insetGrouped)
            .background(Color.clear)
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("\(book.title)")
        .accessibilityLabel("Single Category View")
        .navigationBarBackButtonHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
        .onAppear {
            viewModel.fetchCateoriesByBook(book.title)
            viewModel.fetchPoemsByBook(book.title)
            
            if showBookInfoPopup {
                showBookInfo = true
                showBookInfoPopup = false
                bookInfoPopupCounter += 1
            }
        }
        .sheet(isPresented: $showBookInfo) {
            BookDetailsView(bookName: book.title)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
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
