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
    
    func getCategoryText() -> String {
        if section != nil {
            return "\(mainCategory?.title ?? "") › \(subCategory?.title ?? "") › \(section?.title ?? "")"
        } else if subCategory != nil {
            return "\(mainCategory?.title ?? "") › \(subCategory?.title ?? "")"
        } else {
            return "\(mainCategory?.title ?? "")"
        }
    }
    
    var body: some View {
        ZStack {
            colorTheme.opacity(0.2).ignoresSafeArea()
            
            VStack {
                HStack(spacing: 10) {
                    Text("\(getCategoryText())")
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.95))
                    Spacer()
                }
                .font(.subheadline)
                .padding(.top, 10)
                .padding(.horizontal, 20)
                
                List(viewModel.poems) { poem in
                    NavigationLink(destination: PoemDetailView(colorTheme: colorTheme,
                                                               bookName: bookName,
                                                               poems: viewModel.poems,
                                                               selectedPoem: poem,
                                                               mainCategory: mainCategory?.title ?? "",
                                                               subCategory: subCategory?.title ?? "",
                                                               section: section?.title ?? ""
                                                              )) {
                        Text(poem.poem ?? "No Poem")
                    }
                    
                }
                .scrollContentBackground(Visibility.hidden)
                
//                VStack{
//                    Text(" ")
//                }.frame(height: 50.0)
            }
        }
//        .navigationBarTitle(bookName) //getTitle())
//        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if section != nil {
                viewModel.fetchPoemsBySection(section!)
            } else if mainCategory != nil {
                viewModel.fetchPoemsByCategory(mainCategory!)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    // Search Bar
                    Image("Murugan")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .padding(.trailing, 10)
                    Text(bookName)
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    Image(systemName: "info.circle")
                }
                .padding(0)
            }
        } // toolbar
    }
}

//#Preview {
//    PoemListView()
//}

