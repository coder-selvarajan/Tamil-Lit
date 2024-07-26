//
//  CategoryListViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI

struct CategoryListView: View {
    let colorTheme: Color
    let bookName: String
    @StateObject private var viewModel = CategoryViewModel()
    @State private var showBookInfo: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("பால்:")
                    .foregroundStyle(.black.opacity(0.8))
                    .font(.caption)
                    .fontWeight(.bold)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.mainCategories, id:\.id) { mainCategory in
                            Text("\(mainCategory.title!)")
                                .padding(10)
                                .font(.subheadline)
                                .foregroundColor(viewModel.selectedMainCategory == mainCategory ? .white : .black)
                                .background(viewModel.selectedMainCategory == mainCategory ? colorTheme.opacity(0.8) : .white)
                                .cornerRadius(10.0)
                                .onTapGesture {
                                    viewModel.selectMainCategory(mainCategory)
                                }
                        }
                    }
                }
            }
            .padding(.bottom, 10)
            Divider()
            
            VStack(alignment: .leading) {
                Text("இயல்:")
                    .foregroundStyle(.black.opacity(0.8))
                    .font(.caption)
                    .fontWeight(.bold)
                WrapView(data: viewModel.filteredSubCategories, content: { subCategory in
                    Button(action: {}) {
                        Text(subCategory.title!)
                            .padding(10)
                            .font(.subheadline)
                            .foregroundColor(viewModel.selectedSubCategory == subCategory ? .white : .black)
                            .background(viewModel.selectedSubCategory == subCategory ? colorTheme.opacity(0.8) : .white)
                            .cornerRadius(10.0)
                            .onTapGesture {
                                viewModel.selectSubCategory(subCategory)
                            }
                    }
                })
            }
            .padding(.bottom, 10)
            Divider()
            
            VStack(alignment: .leading) {
                Text("அதிகாரம்:")
                    .foregroundStyle(.black.opacity(0.8))
                    .font(.caption)
                    .fontWeight(.bold)
                //                ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.filteredSections, id:\.self) { section in
                        NavigationLink(destination: PoemListView(colorTheme: colorTheme,
                                                                 bookName: bookName,
                                                                 categoryLevel: 3,
                                                                 mainCategory: viewModel.selectedMainCategory,
                                                                 subCategory: viewModel.selectedSubCategory,
                                                                 section: section)) {
                            HStack {
                                Text("\(section.title!)")
                                    .padding(.vertical, 10)
                                    .foregroundStyle(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                //                }
            }
            
            //            VStack{
            //                Text(" ")
            //            }.frame(height: 50.0)
        }
        .padding(paddingSize)
//        .navigationBarTitle(bookName)
//        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchAllData(bookname: bookName)
        }
        .sheet(isPresented: $showBookInfo) {
            BookDetailsView(bookName: bookName)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image("Murugan")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .padding(.trailing, 10)
                    Text(bookName)
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
                        .foregroundStyle(.black)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .background(colorTheme.opacity(0.3))
                        .cornerRadius(8)
                }
            }
        }
        
    }
}

//#Preview {
//    CategoryListViewModel()
//}
