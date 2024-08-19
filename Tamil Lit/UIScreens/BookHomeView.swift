//
//  BookHomeView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 02/07/24.
//

import SwiftUI

struct BookHomeView: View {
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var themeManager: ThemeManager
    
    let book: BookInfo
    
    @StateObject private var viewModel = CategoryViewModel()
    
    var body: some View {
        ZStack {
            if #available(iOS 16.0, *) {
                if themeManager.selectedTheme == ThemeSelection.colorful {
                    book.color.opacity(0.2).ignoresSafeArea()
                }
            }
            
            if viewModel.book?.name == "பழமொழி நானூறு" {
                SingleCategoryView(book: book)
            } else if viewModel.book?.categoryLevel == 1 {
                PoemListWithCategoryView(book: book)
            } else { 
                // for Thirukural, Naaladiyar
                CategoryListView(book: book)
            }
        }.onAppear {
            viewModel.fetchAllData(bookname: book.title)
        }
    }
}

//#Preview {
//    BookHomeView()
//}
