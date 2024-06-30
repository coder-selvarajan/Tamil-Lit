//
//  MainCategoryListView.swift
//  TamilBookImporter
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI

struct MainCategoryListView: View {
    @StateObject private var viewModel = MainCategoryListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.mainCategories) { mainCategory in
                NavigationLink(destination: SubCategoryListView(mainCategory: mainCategory)) {
                    Text(mainCategory.title ?? "No Title")
                }
            }
            .navigationTitle("Main Categories")
        }
        .onAppear {
            viewModel.fetchMainCategories()
        }
    }
}

