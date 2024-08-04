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
    let book: BookInfo
    
    var mainCategory: MainCategory?
    var subCategory: SubCategory?
    var section: Section?
    
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var themeManager: ThemeManager
    
    @StateObject private var viewModel = PoemListViewModel()
    
    @State private var showBookDetails: Bool = false
    
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
            return "வகை: \(mainCategory?.title ?? "")"
        }
    }
    
    var body: some View {
        ZStack {
            if themeManager.selectedTheme == ThemeSelection.primary {
                colorTheme.opacity(0.2).ignoresSafeArea()
            }
            
            VStack {
                
                List {
                    SwiftUI.Section(header: Text("\(getCategoryText())").font(.headline).foregroundStyle(.primary).padding(.bottom, 10)) {
                        ForEach(viewModel.poems, id:\.self) { poem in
                            NavigationLink(destination: PoemDetailView(colorTheme: colorTheme,
                                                                       bookName: bookName,
                                                                       book: book,
                                                                       poems: viewModel.poems,
                                                                       selectedPoem: poem)) {
                                Text("\(poem.number). \(poem.poem ?? "No Poem")")
                            }
                                                                       .listRowBackground(themeManager.selectedTheme == ThemeSelection.primary ? colorTheme.opacity(0.2) : .gray.opacity(0.2))
                        }
                    }
                }
//                .modifier(ListBackgroundModifier())
                .listStyle(.insetGrouped)
                .background(Color.clear)
                
//                .background(colorTheme)
//                .scrollContentBackground(Visibility.hidden)
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
                            .foregroundStyle(Color("TextColor").opacity(0.8))
                            .padding(.horizontal, size20)
                            .padding(.vertical)
                            .padding(.trailing, size20)
                    }
                    .background(Color("TextColorWhite"))
                    .cornerRadius(size10)
                    .shadow(radius: size10)
                    .padding(.bottom, size30)
                    .padding(.trailing, -size20)
                    
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
        .sheet(isPresented: $showBookDetails) {
            BookDetailsView(bookName: bookName)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    if section == nil {
                        Spacer()
                    }
                    
                    Image(book.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size30)
                        .padding(.trailing, size10)
                    Text(bookName)
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding(0)
            }
            
            ToolbarItem {
                Button {
                    DispatchQueue.main.async {
                        showBookDetails = true
                    }
                } label: {
                    Text("நூல் பற்றி")
                        .font(.subheadline)
                        .foregroundStyle(Color("TextColor"))
                        .padding(.vertical, 5)
                        .padding(.horizontal, size10)
                        .background(themeManager.selectedTheme == .primary ? colorTheme.opacity(0.3) : .gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        } // toolbar
    }
}


//#Preview {
//    PoemListView()
//}

