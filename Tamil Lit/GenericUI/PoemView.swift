//
//  PoemView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI

struct PoemView: View {
    var poem: Poem
    @StateObject private var viewModel = ExplanationListViewModel()

    var body: some View {
        VStack {
            Text("\(poem.number): \n\(poem.poem ?? "")")
            List(viewModel.explanations) { explanation in
                Text("\(explanation.author ?? ""): \n\(explanation.meaning ?? "")")
            }
        }
        .navigationTitle(poem.number.description)
        .onAppear {
            viewModel.fetchExplanations(for: poem)
        }
    }
}

//#Preview {
//    PoemView()
//}
