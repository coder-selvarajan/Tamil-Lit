//
//  RandomPoemView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 19/07/24.
//

import SwiftUI
import PopupView

struct RandomPoemView: View {
    @AppStorage("BooksOptedForRandomPoems") private var bookOptionsData: Data = Data()
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var bookManager: BookManager
    @EnvironmentObject var themeManager: ThemeManager
    
    @State private var bookOptions: [BookInfo] = []
    
    @StateObject private var vm = RandomPoemViewModel()
    @State var randomPoem: Poem?
    
    @State private var showOptions = false
    
    var body: some View {
        ZStack {
            if randomPoem != nil {
                SimplePoemDetailView(selectedPoem: Binding($randomPoem)!)
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        if let poem = vm.getRandomPoem(bookOptions: bookOptions) {
                            performMediumHapticFeedback()
                            randomPoem = poem
                        }
                    } label: {
                            Text("Next...")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                                .padding(.horizontal)
                                .padding(.vertical, size10)
                                .padding(.trailing)
                                .background(userSettings.darkMode ? .orange.opacity(0.9) : .orange.opacity(0.8))
                                .cornerRadius(size10)
                                .shadow(radius: size10)
                    }
                    .padding(.trailing, -size15)
                    .padding(.bottom)
                }
            }
        }
//        .navigationTitle(Text("ஏதோ ஒரு பாடல்"))
//        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("\(randomPoem?.bookname ?? "")-\(String(describing: randomPoem?.number))-\(String(describing: randomPoem?.poem?.prefix(25)))")
        .accessibilityLabel("Ramdom Poem View")
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Random Poem")
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding(0)
            }
            
            ToolbarItem {
                Button {
                    showOptions = true
                } label: {
                    HStack {
                        Image(systemName: "checklist")
                            .font(.footnote)
                            .foregroundColor(Color("TextColor"))
                        
                        Text("Filter")
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color("TextColor"))
                    .padding(.vertical, 7)
                    .padding(.horizontal, size10)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(8)
                }
            }
        }
        .popup(isPresented: $showOptions) {
            let titleString = "Books to include for "
            let subTitleString = "**Random poem pickup** :"
            let attributedTitle = try! AttributedString(markdown: titleString)
            let attributedSubTitle = try! AttributedString(markdown: subTitleString)
            
            BookSelectorView(showModal: $showOptions,
                             booksInfo: $bookOptions, 
                             title: attributedTitle,
                             subTitle: attributedSubTitle) {
                saveBookOptions()
            }
        } customize: {
            $0
                .type(.floater())
                .position(.center)
                .animation(.spring())
                .closeOnTapOutside(true)
                .closeOnTap(false)
                .backgroundColor(userSettings.darkMode ? .white.opacity(0.25) : .black.opacity(0.65))
                .autohideIn(50)
        }
        .onAppear {
            loadBookOptions()
            
            if let poem = vm.getRandomPoem(bookOptions: bookOptions) {
                randomPoem = poem
            }
            
            //Analytics code
            AnalyticsManager.shared.logEvent(
                "Page Load",
                parameters: [
                    "app": "Tamil Lit",
                    "event": "page load",
                    "identifier":"random-poem-view",
                    "viewName":"Random Poem View"
                ]
            )
        }
        .customFontScaling()
    }
    
    private func loadBookOptions() {
        if !bookOptionsData.isEmpty {
            if let decodedOptions = try? JSONDecoder().decode([BookInfo].self, from: bookOptionsData) {
                bookOptions = decodedOptions
                return
            }
        }
        
        bookOptions = bookManager.books
        saveBookOptions()
    }
    
    private func saveBookOptions() {
        if let encodedOptions = try? JSONEncoder().encode(bookOptions) {
            bookOptionsData = encodedOptions
        }
    }
}

#Preview {
    RandomPoemView()
}
