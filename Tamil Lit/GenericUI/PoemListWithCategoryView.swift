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
    @State private var selectedCategoryId: UUID?
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
                                    viewModel.selectedCategory = category
                                    highlightedCategoryId = category.id
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation {
                                            highlightedCategoryId = nil
                                        }
                                    }
                                    
                                    withAnimation {
                                        selectedCategoryId = category.id
                                    }
                                    
                                } label: {
                                    Text(getShortTitle(category))
                                        .font(.subheadline)
                                        .padding(.horizontal, 10)
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
                } // VStack
                .padding(.top)
                
                Divider().padding(.bottom, 10)
                
                VStack(alignment: .leading) {
                    ScrollViewReader { proxy in
                        List {
                            ForEach(viewModel.categories, id:\.id) { category in
                                SwiftUI.Section(header: Text("").id(category.id)) {
                                    SwiftUI.Section(header: Text(category.title ?? "")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(colorTheme)
                                        .padding(.leading, 0)
                                        .padding(.top, 0)) {
                                            // fetch poems by category and display in a section
                                            ForEach(viewModel.fetchPoemsByCategory(category.title ?? ""), id: \.id) { poem in
                                                NavigationLink(destination: PoemDetailView(colorTheme: colorTheme,
                                                                                     bookName: bookName,
                                                                                           poems: viewModel.fetchPoemsByCategory(category.title ?? ""),
                                                                                   selectedPoem: poem)) {
                                                    if let poemText = poem.poem {
                                                        Text(poemText)
                                                    }
                                                }
                                            }
                                        } //Section2
                                } //Section1
//                                .background(
//                                    GeometryReader { geo in
//                                        Color.clear
//                                            .onAppear {
//                                                let frame = geo.frame(in: .global)
//                                                if frame.minY < UIScreen.main.bounds.height / 2 && frame.maxY > UIScreen.main.bounds.height / 2 {
//                                                    highlightedCategoryId = category.id
//                                                }
//                                            }
//                                            .onChange(of: selectedCategoryId) { id in
//                                                if let id = id {
//                                                    withAnimation {
//                                                        proxy.scrollTo(id, anchor: .top)
//                                                    }
//                                                }
//                                            }
//                                    }
//                                )
                            }
                            .onChange(of: selectedCategoryId) { id in
                                if let id = id {
                                    withAnimation(.spring()) {
                                        proxy.scrollTo(id, anchor: .top)
                                    }
                                }
                            }
                        } // List
                        .scrollContentBackground(Visibility.hidden)
                        .scrollIndicators(.hidden)
                        
                    } //ScrollViewReader
                }
            } // VStack
        }
        .onAppear {
            viewModel.fetchCateoriesByBook(bookName)
            viewModel.fetchPoemsByBook(bookName)
            selectedCategoryId = viewModel.selectedCategory?.id
            
            //viewModel.fetchPoemsByCategory()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    // Search Bar
                    Image("Murugan")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .padding(.trailing, 10)
                    Text(bookName)
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    Image(systemName: "info.circle")
                }
                .padding(0)
            }
        } // toolbar
    }
}

//#Preview {
//    PoemListWithCategoryView()
//}
