//
//  PoemListWithCategoryView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 08/07/24.
//

import SwiftUI

struct PoemListWithCategoryView: View {
    let colorTheme: Color
    let bookName: String
//    let categoryLevel: Int
    
    @StateObject private var viewModel = PoemListWithCategoryViewModel()
    @State private var highlightedCategory: String = ""
    
    func getShortTitle(_ category: MainCategory) -> String {
        if let title = category.title, title.starts(with: "பாடல்கள்") {
            return String(describing: category.start) + " - " + String(describing: category.end)
        }

        return category.title ?? ""
    }
    
    var body: some View {
        ZStack {
            colorTheme.opacity(0.2).ignoresSafeArea()
            
//            ScrollView(showsIndicators: false) {
            VStack {
                VStack(alignment: .leading) {
                    Text("வகைகள்: ")
                        .foregroundStyle(.black.opacity(0.8))
                        .font(.footnote)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.categories, id: \.id) { category in
                                Text(getShortTitle(category))
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
                                    .foregroundColor(highlightedCategory == category.title ? .white : .black)
                                    .background(highlightedCategory == category.title ? colorTheme.opacity(0.8) : .white)
                                    .cornerRadius(8.0)
                                    .onTapGesture {
                                        highlightedCategory = category.title ?? ""
                                        viewModel.selectedCategory = category
                                        viewModel.fetchPoemsByCategory()
                                    }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
                
                VStack(alignment: .leading) {
//                    Text("பாடல்கள்: ")
//                        .foregroundStyle(.black.opacity(0.8))
//                        .font(.footnote)
//                        .fontWeight(.bold)
//                        .padding(.horizontal, 20)
//                        .padding(.bottom, 0)
                    
//                    ForEach(viewModel.poems, id: \.id) { poem in
                    List { //}(viewModel.poems) { poem in
                        SwiftUI.Section(header: Text("பாடல்கள்: ").font(.footnote).foregroundStyle(.black).padding(.leading, -10).padding(.top, -20)) {
                            ForEach(viewModel.poems, id: \.id) { poem in
                                NavigationLink(destination: PoemView(colorTheme: colorTheme,
                                                                     bookName: bookName,
                                                                     poem: poem)) {
                                    Text("\(poem.poem!)")
                                    //                                .padding(.vertical, 10)
                                    //                                .foregroundStyle(.black)
                                    //                                .multilineTextAlignment(TextAlignment.leading)
                                    
                                    //                            VStack {
                                    //                                HStack {
                                    //                                    Text("\(poem.poem!)")
                                    //                                        .padding(.vertical, 10)
                                    //                                        .foregroundStyle(.black)
                                    //                                        .multilineTextAlignment(TextAlignment.leading)
                                    //                                    Spacer()
                                    //                                    Image(systemName: "chevron.right")
                                    //                                        .foregroundColor(.gray)
                                    //                                }
                                    //                                Divider()
                                    //                                    .padding(.vertical, 10)
                                    //                            }
                                }
                            }
                        }
                    }
                    .scrollContentBackground(Visibility.hidden)
                    .scrollIndicators(.hidden)
//                    .padding(.vertical, 0)
                    
//                    VStack{
//                        Text(" ")
//                    }.frame(height: 50.0)
                }
//                .padding(.horizontal)
            }
        }
        .navigationBarTitle(bookName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchCateoriesByBook(bookName)
            highlightedCategory = viewModel.selectedCategory?.title ?? ""
            viewModel.fetchPoemsByCategory()
        }
    }
}

//#Preview {
//    PoemListWithCategoryView()
//}
