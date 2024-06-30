//
//  SubCategoryListView.swift
//  TamilBookImporter
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI

struct SubCategoryListView: View {
    var mainCategory: MainCategory
    @StateObject private var viewModel = SubCategoryListViewModel()

    var body: some View {
        List(viewModel.subCategories) { subCategory in
            NavigationLink(destination: SectionListView(subCategory: subCategory)) {
                Text(subCategory.title ?? "No Title")
            }
        }
        .navigationTitle(mainCategory.title ?? "Sub Categories")
        .onAppear {
            viewModel.fetchSubCategories(for: mainCategory)
        }
    }
}
