//
//  FavouritePoemListView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 22/07/24.
//

import SwiftUI

enum PoemListingOrder: String, CaseIterable {
    case ByDate = "Date"
    case ByBook = "Book"
}

struct FavouritePoemListView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    @StateObject private var vm = FavouritePoemViewModel()
    @AppStorage("BooksOptedForFavouritePoems") private var bookOptionsData: Data = Data()
    @State private var bookOptions: [BookInfo] = []
    
    @State private var isShowingDetail: Bool = false
    @State private var selectedPoem: Poem?
    
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
                
                HStack {
                    Text("Show Poems By:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                    Spacer()
                    
                    Picker("Segments", selection: $listingOrder) {
                        ForEach(PoemListingOrder.allCases, id: \.self) { order in
                            Text(order.rawValue).tag(order)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .tint(Color("colorYellow"))
                    .frame(width: UIScreen.main.bounds.width * 0.5)
                }
                .padding()
                
                List {
                    if (listingOrder == .ByBook) { //order by book
                        ForEach(vm.sortedKeys, id: \.self) { bookname in
                            SwiftUI.Section(header:
                                                HStack {
                                Image(systemName: "book.closed.fill") // Replace with your image name
                                    .resizable()
                                    .frame(width: paddingSize, height: paddingSize)
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
                                            isShowingDetail = true
                                        }
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
                                    .frame(width: paddingSize, height: paddingSize)
//                                    .foregroundColor(getColorByBook(bookname))
                                Text(day)
                                    .font(.headline)
                            }) {
                                ForEach(vm.favPoemsByDate[day] ?? [], id: \.id) { favPoem in
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
                                            isShowingDetail = true
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
            }
        }
        .sheet(isPresented: $isShowingDetail) {
            if selectedPoem != nil {
                SimplePoemDetailView(selectedPoem: Binding($selectedPoem)!, popupMode: true)
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
//                .backgroundColor(.black.opacity(0.5))
                .backgroundColor(userSettings.darkMode ? .white.opacity(0.25) : .black.opacity(0.65))
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
                    .padding(.horizontal, 10)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(8)
                }
            }
        }
        .onAppear(){
            loadBookOptions()
            
            vm.getAllFavPoemsCategoried(bookOptions: bookOptions)
            
            if let poem = vm.getRandomPoem() {
                selectedPoem = poem
            }
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
