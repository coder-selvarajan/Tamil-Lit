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
    
//    let colorTheme: Color
//    let bookName: String
    let book: BookInfo
    
    @StateObject private var viewModel = CategoryViewModel()
    
    
    var body: some View {
        ZStack {
            
            if #available(iOS 16.0, *) {
                if themeManager.selectedTheme == ThemeSelection.primary {
                    book.color.opacity(0.2).ignoresSafeArea()
                }
            }
            
            if viewModel.book?.name == "பழமொழி நானூறு" {
                SingleCategoryView(book: book)
            } else if viewModel.book?.categoryLevel == 1 {
                PoemListWithCategoryView(book: book)
            } else {
                CategoryListView(book: book)
            }
            
            // Home button
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    
//                    Button {
//                        // Go to home page
////                        print(navigationPath.count)
//                        //                            navigationPath.removeAll()
//                        //                            presentationMode.wrappedValue.dismiss()
//                    } label: {
//                        Image(systemName: "house.fill")
//                            .font(.title3)
//                            .foregroundStyle(Color("TextColor").opacity(0.8))
//                            .padding(.horizontal, size20)
//                            .padding(.vertical)
//                            .padding(.trailing, size20)
//                    }
//                    .background(Color("TextColorWhite"))
//                    .cornerRadius(size10)
//                    .shadow(radius: size10)
//                    .padding(.bottom, size30)
//                    .padding(.trailing, -size20)
//                    
//                }
//            }
//            .edgesIgnoringSafeArea(.bottom)
            
        }.onAppear {
            viewModel.fetchAllData(bookname: book.title)
        }
        
    }
}

//#Preview {
//    BookHomeView()
//}
