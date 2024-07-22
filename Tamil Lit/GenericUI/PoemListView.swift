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
    
    @State private var showBookInfo: Bool = false
    
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
                    if section == nil {
                        Spacer()
                    }
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
                                                               selectedPoem: poem)) {
                        Text(poem.poem ?? "No Poem")
                    }
                    .listRowBackground(colorTheme.opacity(0.2))
                }
                .scrollContentBackground(Visibility.hidden)
                
//                VStack{
//                    Text(" ")
//                }.frame(height: 50.0)
            }
            
            // Home Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Button {
                        // Go to home page
//                        print(navigationPath.count)
                        //                            navigationPath.removeAll()
                        //                            presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "house.fill")
                            .font(.title3)
                            .foregroundStyle(.black.opacity(0.8))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .padding(.trailing, 20)
                    }
                    .background(.white)
                    .cornerRadius(10.0)
                    .shadow(radius: 10)
                    .padding(.bottom, 30)
                    .padding(.trailing, -20)
                    
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear {
            if section != nil {
                viewModel.fetchPoemsBySection(section!)
            } else if mainCategory != nil {
                viewModel.fetchPoemsByCategory(mainCategory!)
            }
        }
        .sheet(isPresented: $showBookInfo) {
            BookDetailsView(bookName: bookName)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    if section == nil {
                        Spacer()
                    }
                    
                    Image("Murugan")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .padding(.trailing, 10)
                    Text(bookName)
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding(0)
            }
            ToolbarItem {
                Button {
                    showBookInfo = true
                } label: {
                    Text("நூல் பற்றி")
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(colorTheme.opacity(0.3))
                        .cornerRadius(8)
                }
            }
        } // toolbar
    }
}

//#Preview {
//    PoemListView()
//}

