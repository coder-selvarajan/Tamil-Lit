//
//  CategoryListViewModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI

struct CategoryListView: View {
    @StateObject private var viewModel = CategoryListViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                // Main Categories
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.mainCategories) { mainCategory in
                            Text(mainCategory.title ?? "No Title")
                                .padding()
                                .background(viewModel.selectedMainCategory == mainCategory ? Color.blue : Color.clear)
                                .onTapGesture {
                                    viewModel.selectMainCategory(mainCategory)
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
                // Sub Categories
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.subCategories) { subCategory in
                            Text(subCategory.title ?? "No Title")
                                .padding()
                                .background(viewModel.selectedSubCategory == subCategory ? Color.green : Color.clear)
                                .onTapGesture {
                                    viewModel.selectSubCategory(subCategory)
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
                // Sections
                VStack {
                    ForEach(viewModel.sections) { section in
                        Text(section.title ?? "No Title")
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear {
            viewModel.fetchMainCategories()
        }
    }
}

//#Preview {
//    CategoryListViewModel()
//}
