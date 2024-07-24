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
                            randomPoem = poem
                        }
                    } label: {
                        Text("அடுத்து...")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .padding(.trailing, 15)
                            .background(.yellow)
                            .cornerRadius(10.0)
                            .shadow(radius: 10)
                    }.padding(.trailing, -15)
                }
            }
        }
        .navigationTitle(Text("ஏதோ ஒரு பாடல்"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    showOptions = true
                } label: {
                    Image(systemName: "checklist")
                        .foregroundColor(.black)
                }
            }
        }
        .onAppear {
            loadBookOptions()
            
            if let poem = vm.getRandomPoem(bookOptions: bookOptions) {
                randomPoem = poem
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
                .backgroundColor(.black.opacity(0.5))
                .autohideIn(50)
        }
    }
    
    private func loadBookOptions() {
        if !bookOptionsData.isEmpty {
            if let decodedOptions = try? JSONDecoder().decode([BookInfo].self, from: bookOptionsData) {
                bookOptions = decodedOptions
                return
            }
        }
        
        bookOptions = _books
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
