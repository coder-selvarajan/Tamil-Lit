//
//  PoemDetailWrapperView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 15/08/24.
//

import SwiftUI

struct PoemDetailWrapperView: View {
    @EnvironmentObject var bookManager: BookManager
    @StateObject private var vm = PoemDetailsViewModel()
    
    @State var book: BookInfo?
    @State var selectedPoem: Poem
    
    var body: some View {
        VStack {
            PoemDetailView(book: book ?? bookManager.books.last!,
                           poems: vm.poemsByCategoryNames ?? [],
                           selectedPoem: selectedPoem,
                           showHomeButton: false)
        }
        .onAppear() {
            book = bookManager.books.first(where: { book in
                book.title == selectedPoem.bookname!
            })!
            
            vm.getPoemsByCategory(bookName: book?.title ?? "",
                                  mainCategory: selectedPoem.maincategoryname ?? "",
                                  subCategory: selectedPoem.subcategoryname ?? "",
                                  section: selectedPoem.sectionname ?? "")
        }
    }
}

