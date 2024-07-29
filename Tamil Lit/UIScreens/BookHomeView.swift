//
//  BookHomeView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 02/07/24.
//

import SwiftUI

struct BookHomeView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    let colorTheme: Color
    let bookName: String
//    let book: Book?
    @StateObject private var viewModel = CategoryViewModel()
    
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            colorTheme.opacity(userSettings.darkMode ? 0.5 : 0.3).ignoresSafeArea()
            
            if viewModel.book?.name == "பழமொழி நானூறு" {
                SingleCategoryView(colorTheme: colorTheme, bookName: bookName)
            } else if viewModel.book?.categoryLevel == 1 {
                PoemListWithCategoryView(colorTheme: colorTheme, bookName: bookName)
            } else {
                CategoryListView(colorTheme: colorTheme, bookName: bookName)
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Button {
                        // Go to home page
//                        print(navigationPath.count)
                        //                            navigationPath.removeAll()
                        //                            presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "house.fill")
                            .font(.title3)
                            .foregroundStyle(.black.opacity(0.8))
                            .padding(.horizontal, paddingSize)
                            .padding(.vertical, 15)
                            .padding(.trailing, paddingSize)
                    }
                    .background(.white)
                    .cornerRadius(10.0)
                    .shadow(radius: 10)
                    .padding(.bottom, 30)
                    .padding(.trailing, -paddingSize)
                    
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            
        }.onAppear {
            viewModel.fetchAllData(bookname: bookName)
        }
        
    }
}

//#Preview {
//    BookHomeView()
//}
