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
            colorTheme.opacity(0.3).ignoresSafeArea()
            
            if viewModel.book?.categoryLevel == 1 {
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
                            .padding(15)
                    }
                    .background(.white)
                    .cornerRadius(10.0)
                    .shadow(radius: 10)
                    .padding(20)
                    
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
