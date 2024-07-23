//
//  FavouritePoemListView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 22/07/24.
//

import SwiftUI

enum PoemListingOrder {
    case ByDate, ByBook
}

struct FavouritePoemListView: View {
    @StateObject private var vm = FavouritePoemViewModel()
    @AppStorage("BooksOptedForFavouritePoems") private var bookOptionsData: Data = Data()
    @State private var bookOptions: [BookInfo] = []
    
    @State private var selectedPoem: Poem? = nil
    @State private var isShowingDetail: Bool = false
    
    @State private var listingOrder: PoemListingOrder = .ByBook
    
    @State private var showOptions = false
    
    func getCategoryDisplay(_ poem: FavouritePoem) -> String {
        if let section = poem.sectionname, section != "", !section.starts(with: "பாடல்") {
            return " - " + section
        } else if let subCat = poem.subcategoryname, subCat != "", !subCat.starts(with: "பாடல்") {
            return " - " + subCat
        } else if let mainCat = poem.maincategoryname, mainCat != "", !mainCat.starts(with: "பாடல்") {
            return " - " + mainCat
        }
        return ""
    }
    
    func getCategoryDisplayAlone(_ poem: FavouritePoem) -> String {
        return getCategoryDisplay(poem).replacingOccurrences(of: " - ", with: "")
    }
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    if (listingOrder == .ByBook) { //order by book
                        ForEach(vm.sortedKeys, id: \.self) { bookname in
                            SwiftUI.Section(header:
                                                HStack {
                                Image(systemName: "book.closed.fill") // Replace with your image name
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(getColorByBook(bookname))
                                Text(bookname)
                                    .font(.headline)
                            }) {
                                ForEach(vm.favPoemsByCategory[bookname] ?? [], id: \.self) { favPoem in
                                    VStack(alignment: .leading) {
                                        let cat = getCategoryDisplayAlone(favPoem)
                                        if cat != "" {
                                            Text("\(cat)")
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                        }
                                        
                                        if let title = favPoem.title, title != "" {
                                            Text(title).font(.headline)
                                        }
                                        
                                        if let poemText = favPoem.poem {
                                            Text("\(poemText)  (\(favPoem.number))")
                                        }
                                    }
                                    .onTapGesture {
                                        if let poem = vm.getPoemFromFavPoem(favPoem: favPoem) {
                                            selectedPoem = poem
                                        }
                                        isShowingDetail = true
                                    }
                                }
                            }
                        }
                    } else { // order by date
//                        ForEach(vm.favPoems, id:\.id) { favPoem in
//                            Text("\(favPoem.bookname ?? "") - \(favPoem.poem ?? "")")
//                        }
                        ForEach(vm.favPoemsByDate.keys.sorted().reversed(), id: \.self) { day in
                            SwiftUI.Section(header:
                                                HStack {
                                Image(systemName: "calendar") // Replace with your image name
                                    .resizable()
                                    .frame(width: 20, height: 20)
//                                    .foregroundColor(getColorByBook(bookname))
                                Text(day)
                                    .font(.headline)
                            }) {
                                ForEach(vm.favPoemsByDate[day] ?? [], id: \.self) { favPoem in
                                    VStack(alignment: .leading) {
                                        
                                        Text("\(favPoem.bookname ?? "")\(getCategoryDisplay(favPoem))")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        
                                        if let title = favPoem.title, title != "" {
                                            Text("\(title):").font(.headline)
                                        }
                                        
                                        if let poemText = favPoem.poem {
                                            Text("\(poemText)  (\(favPoem.number))")
                                        }
                                    }
                                    .onTapGesture {
                                        if let poem = vm.getPoemFromFavPoem(favPoem: favPoem) {
                                            selectedPoem = poem
                                        }
                                        isShowingDetail = true
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .sheet(isPresented: $isShowingDetail) {
                    SimplePoemDetailView(selectedPoem: $selectedPoem, popupMode: true)
                }
            }
        }
        .popup(isPresented: $showOptions) {
            let titleString = "Books to include in "
            let subTitleString = "**Favourites** :"
            let attributedTitle = try! AttributedString(markdown: titleString)
            let attributedSubTitle = try! AttributedString(markdown: subTitleString)
            
            BookSelectorView(showModal: $showOptions,
                             booksInfo: $bookOptions,
                             title: attributedTitle,
                             subTitle: attributedSubTitle) {
                saveBookOptions()
                vm.getAllFavPoemsCategoried(bookOptions: bookOptions)
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
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("சேமித்த பாடல்கள்")
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding(0)
            }
            
            ToolbarItem {
                Menu {
                    Button(action: {
                        listingOrder = .ByBook
                    }) {
                        Text("Order by Book")
                    }
                    Button(action: {
                        listingOrder = .ByDate
                    }) {
                        Text("Order by Date")
                    }
                    
                } label: {
                    HStack {
//                        Text("Order ")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
                        Image(systemName: "arrow.up.arrow.down.square")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                }
            }
            
            ToolbarItem {
                Button {
                    showOptions = true
                } label: {
                    Image(systemName: "checklist")
                        .foregroundColor(.black)
                }
            }
            
        }
        .onAppear(){
            loadBookOptions()
            
            vm.getAllFavPoemsCategoried(bookOptions: bookOptions)
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
    FavouritePoemListView()
}
