//
//  SectionListView.swift
//  TamilBookImporter
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI

struct SectionListView: View {
    var subCategory: SubCategory
    @StateObject private var viewModel = SectionListViewModel()

    var body: some View {
        List(viewModel.sections) { section in
            NavigationLink(destination: PoemListView(section: section)) {
                Text(section.title ?? "No Title")
            }
        }
        .navigationTitle(subCategory.title ?? "Sections")
        .onAppear {
            viewModel.fetchSections(for: subCategory)
        }
    }
}

