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
    
    @StateObject var viewModel = PoemListWithCategoryViewModel()
    @State private var highlightedCategoryId: UUID?
    
    func getShortTitle(_ category: MainCategory) -> String {
        if let title = category.title, title.starts(with: "பாடல்கள்") {
            return String(describing: category.start) + " - " + String(describing: category.end)
        }
        
        return category.title ?? ""
    }
    
    var body: some View {
        ZStack {
            colorTheme.opacity(0.2).ignoresSafeArea()
            
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
                                Button {
//                                    highlightedCategory = category.title ?? ""
                                    viewModel.selectedCategory = category
                                    
                                    withAnimation {
                                        highlightedCategoryId = category.id
                                    }
                                } label: {
                                    Text(getShortTitle(category))
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                        .foregroundColor(highlightedCategoryId == category.id ? .white : .black)
                                        .background(highlightedCategoryId == category.id ? colorTheme.opacity(0.8) : .white.opacity(0.8))
                                        .cornerRadius(8.0)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
                
                VStack(alignment: .leading) {
                    ScrollViewReader { proxy in
                        List {
                            ForEach(viewModel.categories, id:\.id) { category in
                                SwiftUI.Section(header: Text(category.title ?? "")
                                    .font(.footnote)
                                    .foregroundStyle(.black)
                                    .padding(.leading, -10)
                                    .id(category.id)) {
                                        // fetch poems by category and display in a section
                                        ForEach(viewModel.fetchPoemsByCategory(category.title ?? ""), id: \.id) { poem in
                                            NavigationLink(destination: PoemView(colorTheme: colorTheme,
                                                                                 bookName: bookName,
                                                                                 poem: poem)) {
                                                if let poemText = poem.poem {
                                                    Text(poemText)
                                                }
                                            }
                                        }
                                    }
//                                    .background(
//                                        GeometryReader { geo in
//                                            Color.clear
//                                                .onAppear {
//                                                    let frame = geo.frame(in: .global)
//                                                    if frame.minY < UIScreen.main.bounds.height / 2 && frame.maxY > UIScreen.main.bounds.height / 2 {
//                                                        highlightedCategoryId = category.id
//                                                    }
//                                                }
//                                                .onChange(of: highlightedCategoryId) { _ in
//                                                    if let id = highlightedCategoryId {
//                                                        withAnimation {
//                                                            proxy.scrollTo(id, anchor: .top)
//                                                        }
//                                                    }
//                                                }
//                                        }
//                                    )
                            }
                        }
                        .scrollContentBackground(Visibility.hidden)
                        .scrollIndicators(.hidden)
                        .onChange(of: highlightedCategoryId) { id in
                            if let id = id {
                                proxy.scrollTo(id, anchor: .topTrailing)
                            }
                        }
                    }
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
            viewModel.fetchPoemsByBook(bookName)
            
//            highlightedCategory = viewModel.selectedCategory?.title ?? ""
            
            //viewModel.fetchPoemsByCategory()
        }
    }
}

//#Preview {
//    PoemListWithCategoryView()
//}
