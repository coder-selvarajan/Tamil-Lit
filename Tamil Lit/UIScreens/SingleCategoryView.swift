//
//  SingleCategoryView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 06/07/24.
//

import SwiftUI

struct SingleCategoryView: View {
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
                .listRowBackground(themeManager.selectedTheme == ThemeSelection.primary ? book.color.opacity(0.2) : .gray.opacity(0.1))
            }
            .modifier(ListBackgroundModifier())
            .listStyle(.insetGrouped)
            .background(Color.clear)
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
                    Text("நூல் பற்றி")
                        .font(.subheadline)
                        .foregroundStyle(Color("TextColor"))
                        .padding(.vertical, 7)
                        .padding(.horizontal, size10)
                        .background(themeManager.selectedTheme == .primary ? book.color.opacity(0.3) : .gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        }
        .onAppear {
            viewModel.fetchCateoriesByBook(book.title)
            viewModel.fetchPoemsByBook(book.title)
        }
        .customFontScaling()
    }
}
