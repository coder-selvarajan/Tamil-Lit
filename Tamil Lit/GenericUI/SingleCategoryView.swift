//
//  SingleCategoryView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 06/07/24.
//

import SwiftUI

struct SingleCategoryView: View {
    let colorTheme: Color
    let bookName: String
    @StateObject private var viewModel = CategoryViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("Categories:")
                    .foregroundStyle(.black.opacity(0.8))
                    .font(.caption)
                    .fontWeight(.bold)
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.mainCategories, id:\.self) { category in
                            NavigationLink(destination: PoemListView(colorTheme: colorTheme,
                                                                     bookName: bookName,
                                                                     categoryLevel: 1)) {
                                 HStack {
                                    Text("\(category.title!)")
                                        .padding(.vertical, 10)
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
            }
            
//            VStack{
//                Text(" ")
//            }.frame(height: 50.0)
        }
        .padding(20)
        .navigationBarTitle(bookName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchAllData(bookname: bookName)
        }
    }
}

//#Preview {
//    SingleCategoryView()
//}
