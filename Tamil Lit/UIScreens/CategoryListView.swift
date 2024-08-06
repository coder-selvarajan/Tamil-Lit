//
//  CategoryListViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI

struct CategoryListView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    let book: BookInfo
    
    @StateObject private var viewModel = CategoryViewModel()
    @State private var showBookInfo: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("பால்:")
                    .foregroundStyle(Color("TextColor").opacity(0.8))
                    .font(.caption.bold())
                    
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.mainCategories, id:\.id) { mainCategory in
                            if themeManager.selectedTheme == .primary {
                                Text("\(mainCategory.title!)")
                                    .padding(size10)
                                    .font(.subheadline)
                                    .foregroundColor(viewModel.selectedMainCategory == mainCategory ? .white : .black)
                                    .background(viewModel.selectedMainCategory == mainCategory 
                                                ? book.color.opacity(0.8) : .white)
                                    .cornerRadius(size10)
                                    .onTapGesture {
                                        viewModel.selectMainCategory(mainCategory)
                                    }
                            } else { // light, dark
                                Text("\(mainCategory.title!)")
                                    .padding(size10)
                                    .font(.subheadline)
                                    .foregroundColor(viewModel.selectedMainCategory == mainCategory
                                                     ? Color("TextColorWhite") : Color("TextColor"))
                                    .background(viewModel.selectedMainCategory == mainCategory
                                                ? Color("TextColor").opacity(0.6) : .gray.opacity(0.2))
                                    .cornerRadius(size10)
                                    .onTapGesture {
                                        viewModel.selectMainCategory(mainCategory)
                                    }
                            }
                        }
                    }
                }
            }
            .padding(.bottom, size10)
            Divider()
            
            VStack(alignment: .leading) {
                Text("இயல்:")
                    .foregroundStyle(Color("TextColor").opacity(0.8))
                    .font(.caption.bold())
                    
                WrapView(data: viewModel.filteredSubCategories, content: { subCategory in
                    Button(action: {}) {
                        if themeManager.selectedTheme == .primary {
                            Text(subCategory.title!)
                                .padding(size10)
                                .font(.subheadline)
                                .foregroundColor(viewModel.selectedSubCategory == subCategory ? .white : .black)
                                .background(viewModel.selectedSubCategory == subCategory 
                                            ? book.color.opacity(0.8) : .white)
                                .cornerRadius(size10)
                                .onTapGesture {
                                    viewModel.selectSubCategory(subCategory)
                                }
                        } else {
                            Text(subCategory.title!)
                                .padding(size10)
                                .font(.subheadline)
                                .foregroundColor(viewModel.selectedSubCategory == subCategory 
                                                 ? Color("TextColorWhite") : Color("TextColor"))
                                .background(viewModel.selectedSubCategory == subCategory
                                            ? Color("TextColor").opacity(0.6) : .gray.opacity(0.2))
                                .cornerRadius(size10)
                                .onTapGesture {
                                    viewModel.selectSubCategory(subCategory)
                                }
                        }
                    }
                })
            }
            .padding(.bottom, size10)
            Divider()
            
            VStack(alignment: .leading) {
                Text("அதிகாரம்:")
                    .foregroundStyle(Color("TextColor").opacity(0.8))
                    .font(.caption.bold())
                    
                //                ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.filteredSections, id:\.self) { section in
                        NavigationLink(destination: PoemListView(book: book,
                                                                 mainCategory: viewModel.selectedMainCategory,
                                                                 subCategory: viewModel.selectedSubCategory,
                                                                 section: section)) {
                            VStack {
                                HStack(alignment: .center) {
                                 
                                    VStack(alignment: .leading) {
                                        Text("\(section.title ?? "")")
                                            .font(.body.bold())
                                            .foregroundStyle(Color("TextColor"))
                                        
                                        Text("\(viewModel.book?.poemType ?? ""): \(section.start)..\(section.end)")
                                            .foregroundStyle(Color("TextColor").opacity(0.5))
                                            .font(.footnote)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.secondary)
                                }
                                
                                Divider()
                            }
                        }
                    }
                }                
            }
            
        }
        .padding(size20)
        .onAppear {
            viewModel.fetchAllData(bookname: book.title)
        }
        .sheet(isPresented: $showBookInfo) {
            BookDetailsView(bookName: book.title)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(book.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size30)
                        .padding(.trailing, size10)
                    Text(book.title)
                        .font(.body)
                        .fontWeight(.semibold)
                    
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
                        .foregroundStyle(Color("TextColor"))
                        .padding(.vertical, 7)
                        .padding(.horizontal, size10)
                        .background(themeManager.selectedTheme == .primary ? book.color.opacity(0.3) : .gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        }
        .customFontScaling()
    }
}
