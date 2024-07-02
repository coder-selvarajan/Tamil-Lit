//
//  PoemView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI

struct PoemView: View {
    let colorTheme: Color
    let bookName: String
    let poem: Poem
    @StateObject private var viewModel = ExplanationListViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            colorTheme.opacity(0.2).ignoresSafeArea()
            
            VStack {
                Text("\(poem.number): \n\(poem.poem ?? "")")
                List(viewModel.explanations) { explanation in
                    Text("\(explanation.author ?? ""): \n\(explanation.meaning ?? "")")
                }
                
                VStack{
                    Text(" ")
                }.frame(height: 50.0)
            }
        }
        .navigationTitle(poem.section?.title ?? "")
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .onAppear {
            viewModel.fetchExplanations(for: poem)
        }
    }
}

//#Preview {
//    PoemView()
//}
