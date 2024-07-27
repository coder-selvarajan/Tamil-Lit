//
//  SingleCategoryView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 06/07/24.
//

import SwiftUI

struct SingleCategoryView: View {
    let colorTheme: Color
    let bookName: String
    @StateObject private var viewModel = SingleCategoryViewModel()
    @State private var showBookInfo: Bool = false
    
    var body: some View {
//        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                List {
                    SwiftUI.Section(header: Text("வகைகள்: ").fontWeight(.bold)) {
                        ForEach(viewModel.categories, id:\.self) { category in
                            if let title = category.title {
                                NavigationLink(destination:
                                                PoemListView(colorTheme: colorTheme,
                                                             bookName: bookName,
                                                             categoryLevel: 1,
                                                             mainCategory: category)) {
                                    Text(title)
                                }
                            }
                        }
                    }
                    .listRowBackground(colorTheme.opacity(0.2))
                }
//                .listStyle(PlainListStyle())
                .scrollContentBackground(Visibility.hidden)
                .scrollIndicators(.hidden)
            }
            
//        .navigationBarTitle(bookName)
//        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showBookInfo) {
            BookDetailsView(bookName: bookName)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
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
                    .foregroundStyle(Color("TextColor"))
                    .padding(.vertical, 7)
                    .padding(.horizontal, 10)
                    .background(colorTheme.opacity(0.3))
                    .cornerRadius(8)
                    
                }
            }
        }
        .onAppear {
            viewModel.fetchCateoriesByBook(bookName)
            viewModel.fetchPoemsByBook(bookName)
        }
    }
}

//#Preview {
//    SingleCategoryView()
//}
