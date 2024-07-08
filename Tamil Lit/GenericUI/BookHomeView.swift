//
//  BookHomeView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 02/07/24.
//

import SwiftUI

struct BookHomeView: View {
    let colorTheme: Color
    let bookName: String
//    let book: Book?
    @StateObject private var viewModel = CategoryViewModel()
    
    
    var body: some View {
        ZStack {
            colorTheme.opacity(0.2).ignoresSafeArea()
            if viewModel.book?.categoryLevel == 1 {
                if bookName == "ஆத்திச்சூடி" {
                    SingleCategoryView(colorTheme: colorTheme, bookName: bookName)
                } else {
                    PoemListWithCategoryView(colorTheme: colorTheme, bookName: bookName)
                }
            } else {
                CategoryListView(colorTheme: colorTheme, bookName: bookName)
            }
        }.onAppear {
            viewModel.fetchAllData(bookname: bookName)
        }
        
    }
}

//#Preview {
//    BookHomeView()
//}
