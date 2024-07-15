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
    @StateObject private var viewModel = SingleCategoryViewModel()
    
    var body: some View {
//        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
//                Text("வகைகள்:")
//                    .foregroundStyle(.black.opacity(0.8))
//                    .font(.caption)
//                    .fontWeight(.bold)
                
                List {
                    SwiftUI.Section(header: Text("வகைகள்: ").fontWeight(.bold)) {
                        ForEach(viewModel.categories, id:\.self) { category in
                            if let title = category.title {
                                NavigationLink(destination:
                                                PoemListView(colorTheme: colorTheme,
                                                             bookName: bookName,
                                                             categoryLevel: 1,
                                                             mainCategory: category)) {
                                    Text(title)
                                }
                            }
                        }
                    }
                    .listRowBackground(colorTheme.opacity(0.2))
                }
//                .listStyle(PlainListStyle())
                .scrollContentBackground(Visibility.hidden)
                .scrollIndicators(.hidden)
                
//                VStack {
//                    LazyVStack(alignment: .leading) {
////                    List {
//                        ForEach(viewModel.categories, id:\.self) { category in
//                            NavigationLink(destination:
//                                            PoemListView(colorTheme: colorTheme,
//                                                         bookName: bookName,
//                                                         categoryLevel: 1,
//                                                         mainCategory: category)) {
//                                Text("\(category.title!)")
////                                HStack {
////                                    Text("\(category.title!)")
////                                        .font(.body)
////                                        .padding(.vertical, 10)
////                                        .foregroundStyle(.black)
////                                    Spacer()
////                                    Image(systemName: "chevron.right")
////                                        .foregroundColor(.gray)
////                                }
//                            }
//                        }
//                    }
//                }
            }
            
            //            VStack{
            //                Text(" ")
            //            }.frame(height: 50.0)
//        }
//        .padding(20)
        .navigationBarTitle(bookName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchCateoriesByBook(bookName)
            viewModel.fetchPoemsByBook(bookName)
        }
    }
}

//#Preview {
//    SingleCategoryView()
//}
