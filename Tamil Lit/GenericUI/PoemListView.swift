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
    let categoryLevel: Int
    
    var mainCategory: MainCategory?
    var subCategory: SubCategory?
    var section: Section?
    
    @StateObject private var viewModel = PoemListViewModel()
//    @State private var poems: [Poem]
    
    
    func getTitle() -> String {
        if let title = section?.title {
            return title
        }
        
        if let title = subCategory?.title {
            return title
        }
        
        if let title = mainCategory?.title {
            return title
        }
        
        return ""
    }

    var body: some View {
        ZStack {
            colorTheme.opacity(0.2).ignoresSafeArea()
            
            VStack {
                List(viewModel.poems) { poem in
                    NavigationLink(destination: PoemDetailView(colorTheme: colorTheme,
                                                               bookName: bookName,
                                                               poems: viewModel.poems,
                                                               selectedPoem: poem)) {
                        Text(poem.poem ?? "No Poem")
                    }
                    
                }
                .scrollContentBackground(Visibility.hidden)
                
//                VStack{
//                    Text(" ")
//                }.frame(height: 50.0)
            }
        }
        .navigationBarTitle(getTitle())
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if section != nil {
                viewModel.fetchPoemsBySection(section!)
            } else if mainCategory != nil {
                viewModel.fetchPoemsByCategory(mainCategory!)
            }
        }
    }
}

//#Preview {
//    PoemListView()
//}

