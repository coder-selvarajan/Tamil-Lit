//
//  PoemListView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI

struct PoemListView: View {
    @EnvironmentObject var userSettings: UserSettings
    
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
            Color.white.ignoresSafeArea()
//            colorTheme.opacity(0.2).ignoresSafeArea()
            colorTheme.opacity(userSettings.darkMode ? 0.5 : 0.3).ignoresSafeArea()
            
            VStack {
                HStack(spacing: size10) {
                    if section == nil {
                        Spacer()
                    }
                    Text("\(getCategoryText())")
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.95))
                    Spacer()
                }
                .font(.subheadline)
                .padding(.top, size10)
                .padding(.horizontal, size20)
                
                List(viewModel.poems) { poem in
                    NavigationLink(destination: PoemDetailView(colorTheme: colorTheme,
                                                               bookName: bookName,
                                                               poems: viewModel.poems,
                                                               selectedPoem: poem)) {
                        Text("\(poem.number). \(poem.poem ?? "No Poem")")
                            .foregroundStyle(.black)
                    }
                    .listRowBackground(colorTheme.opacity(0.2))
                }
                .scrollContentBackground(Visibility.hidden)
            }
            
            // Home Button
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    
//                    Button {
//                        // Go to home page
////                        print(navigationPath.count)
//                        //                            navigationPath.removeAll()
//                        //                            presentationMode.wrappedValue.dismiss()
//                    } label: {
//                        Image(systemName: "house.fill")
//                            .font(.title3)
//                            .foregroundStyle(Color("TextColor").opacity(0.8))
//                            .padding(.horizontal, size20)
//                            .padding(.vertical)
//                            .padding(.trailing, size20)
//                    }
//                    .background(Color("TextColorWhite"))
//                    .cornerRadius(size10)
//                    .shadow(radius: size10)
//                    .padding(.bottom, size30)
//                    .padding(.trailing, -size20)
//                    
//                }
//            }
//            .edgesIgnoringSafeArea(.bottom)
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
                    
                    Image("Thiruvalluvar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: size30)
                        .padding(.trailing, size10)
                    Text(bookName)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
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
                        .padding(.horizontal, size10)
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

