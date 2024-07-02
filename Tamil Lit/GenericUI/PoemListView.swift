//
//  PoemListView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI

struct PoemListView: View {
    let colorTheme: Color
    let bookName: String
    let section: Section
    @StateObject private var viewModel = PoemListViewModel()

    var body: some View {
        ZStack {
            colorTheme.opacity(0.2).ignoresSafeArea()
            
            VStack {
                List(viewModel.poems) { poem in
                    NavigationLink(destination: PoemView(colorTheme: colorTheme,
                                                         bookName: bookName,
                                                         poem: poem)) {
                        Text(poem.poem ?? "No Poem")
                    }
                    
                }
                .scrollContentBackground(Visibility.hidden)
                
                VStack{
                    Text(" ")
                }.frame(height: 50.0)
            }
        }
        .navigationBarTitle(section.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchPoems(for: section)
        }
    }
}

//#Preview {
//    PoemListView()
//}

