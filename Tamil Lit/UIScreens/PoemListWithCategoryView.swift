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
    
    @EnvironmentObject var userSettings: UserSettings
    @StateObject var viewModel = PoemListWithCategoryViewModel()
    @State private var selectedCategoryId: UUID?
    @State private var highlightedCategoryId: UUID?
    
    @State private var showBookInfo: Bool = false
    
    func getShortTitle(_ category: MainCategory) -> String {
        if let title = category.title, title.starts(with: "பாடல்கள்") {
            return String(describing: category.start) + " - " + String(describing: category.end)
        }
        
        return category.title ?? ""
    }
    
    var body: some View {
        ZStack {
//            colorTheme.opacity(0.2).ignoresSafeArea()
            
            VStack {
                VStack(alignment: .leading) {
                    Text("வகைகள்: ")
                        .foregroundStyle(.black.opacity(0.8))
                        .font(.footnote.bold())
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: size10) {
                            ForEach(viewModel.categories, id: \.id) { category in
                                Button {
                                    viewModel.selectedCategory = category
                                    highlightedCategoryId = category.id
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        withAnimation {
                                            highlightedCategoryId = nil
                                        }
                                    }
                                    
                                    withAnimation {
                                        selectedCategoryId = category.id
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        selectedCategoryId = nil
                                    }
                                } label: {
                                    Text(getShortTitle(category))
                                        .font(.subheadline)
                                        .padding(.horizontal, size10)
                                        .padding(.vertical, size10)
                                        .foregroundColor(highlightedCategoryId == category.id ? .white : .black)
                                        .background(highlightedCategoryId == category.id
                                                    ? colorTheme.opacity(0.7)
                                                    : (userSettings.darkMode ? colorTheme.opacity(0.5) : .white.opacity(0.7)))
                                        .cornerRadius(8.0)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, size10)
                    }
                } // VStack
                .padding(.top)
                
                Divider().padding(.bottom, size10).padding(.top, 0)
                
                VStack(alignment: .leading) {
                    ScrollViewReader { proxy in
                        List {
                            ForEach(viewModel.categories, id:\.id) { category in
                                SwiftUI.Section(header: EmptyView().frame(height: 0).id(category.id)) {
                                    SwiftUI.Section(header: Text(category.title ?? "")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                        .padding(.leading, 0)
                                        .padding(.top, 0)) {
                                            // fetch poems by category and display in a section
                                            ForEach(viewModel.fetchPoemsByCategory(category.title ?? ""), id: \.id) { poem in
                                                NavigationLink(destination: 
                                                PoemDetailView(colorTheme: colorTheme,
                                                               bookName: bookName,
                                                               poems: viewModel.fetchPoemsByCategory(category.title ?? ""),
                                                               selectedPoem: poem)) {
                                                    if let poemText = poem.poem {
                                                        Text(poemText)
                                                            .foregroundStyle(.black)
                                                    }
                                                }
                                            }
                                        } //Section2
                                } //Section1
                                .listRowBackground(colorTheme.opacity(0.2))
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
//                            .listRowBackground(colorTheme.opacity(0.2))
                            .onChange(of: selectedCategoryId) { id in
                                if let id = id {
                                    withAnimation(.spring()) {
                                        proxy.scrollTo(id, anchor: .top)
                                    }
                                }
                            }
                        } // List
                        .listStyle(.insetGrouped)
//                        .listRowBackground(Color(.systemGray6))
//                        .background(colorTheme.opacity(0.1))
                        
//                        .scrollContentBackground(Visibility.hidden)
//                        .scrollIndicators(.hidden)
                        .padding(.top, -5)
//                        .background(colorTheme) // Use background instead of scrollContentBackground
//                        .onAppear {
//                            UITableView.appearance().backgroundColor = colorTheme
//                            UITableView.appearance().showsVerticalScrollIndicator = false // Hide scroll indicators
//                        }
                        
                    } //ScrollViewReader
                }
            } // VStack
            
        }
        .onAppear {
            viewModel.fetchCateoriesByBook(bookName)
            viewModel.fetchPoemsByBook(bookName)
//            selectedCategoryId = viewModel.selectedCategory?.id
            
            //viewModel.fetchPoemsByCategory()
        }
        .sheet(isPresented: $showBookInfo) {
            BookDetailsView(bookName: bookName)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    // Search Bar
                    Image("Thiruvalluvar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: size30)
                        .padding(.trailing, size10)
                    Text(bookName)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                }
                .padding(0)
            }
            
            ToolbarItem {
                Button {
                    showBookInfo = true
                } label: {
                    Text("நூல் பற்றி")
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .padding(.vertical, 5)
                        .padding(.horizontal, size10)
                        .background(colorTheme.opacity(0.3))
                        .cornerRadius(8)
                }
            }
        }
    }
}

//#Preview {
//    PoemListWithCategoryView()
//}
