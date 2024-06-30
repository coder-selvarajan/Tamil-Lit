//
//  PoemListView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI

struct PoemListView: View {
    var section: Section
    @StateObject private var viewModel = PoemListViewModel()

    var body: some View {
        List(viewModel.poems) { poem in
            NavigationLink(destination: PoemView(poem: poem)) {
                Text(poem.poem ?? "No Poem")
            }
            
        }
        .navigationTitle(section.title ?? "Sections")
        .onAppear {
            viewModel.fetchPoems(for: section)
        }
    }
}

//#Preview {
//    PoemListView()
//}

