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

struct SavedPoemListView: View {
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var bookManager: BookManager
    
    @StateObject private var vm = SavedPoemViewModel()
    @AppStorage("BooksOptedForSavedPoems") private var bookOptionsData: Data = Data()
    @State private var bookOptions: [BookInfo] = []
    
    @State private var isShowingDetail: Bool = false
    @State private var selectedPoem: Poem?
    
    @State private var listingOrder: PoemListingOrder = .ByBook
    @State private var showOptions = false
    
    func getCategoryDisplay(_ poem: Poem) -> String {
        if let section = poem.sectionname, section != "", !section.starts(with: "பாடல்") {
            return " - " + section
        } else if let subCat = poem.subcategoryname, subCat != "", !subCat.starts(with: "பாடல்") {
            return " - " + subCat
        } else if let mainCat = poem.maincategoryname, mainCat != "", !mainCat.starts(with: "பாடல்") {
            return " - " + mainCat
        }
        return ""
    }
    
    func getCategoryDisplayAlone(_ poem: Poem) -> String {
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
                                    .frame(width: size20, height: size20)
                                    .foregroundColor(getColorByBook(bookname))
                                Text(bookname)
                                    .font(.headline)
                            }) {
                                ForEach(vm.favPoemsByCategory[bookname] ?? [], id: \.self) { favPoem in
                                    NavigationLink(destination: PoemDetailWrapperView(selectedPoem: favPoem))
                                    {
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
                                    }
                                }
                            }
                        }
                    } else { // order by date
                        ForEach(vm.favPoemsByDate.keys.sorted().reversed(), id: \.self) { day in
                            SwiftUI.Section(header:
                                                HStack {
                                Image(systemName: "calendar") // Replace with your image name
                                    .resizable()
                                    .frame(width: size20, height: size20)
                                Text(day)
                                    .font(.headline)
                            }) {
                                ForEach(vm.favPoemsByDate[day] ?? [], id: \.id) { favPoem in
                                    NavigationLink(destination: PoemDetailWrapperView(selectedPoem: favPoem))
                                    {
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
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("saved-poems-list-view")
        .accessibilityLabel("Saved Poems List View")
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
                    Image(systemName: "bookmark")
                        .resizable()
                        .scaledToFit()
                        .frame(height: size20)
                        .padding(.trailing, size10)
                    
                    Text("Saved Poems")
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
        .onAppear(){
            loadBookOptions()
            
            vm.getAllFavPoemsCategoried(bookOptions: bookOptions)
            
            if let poem = vm.getRandomPoem() {
                selectedPoem = poem
            }
            
            //Analytics code
            AnalyticsManager.shared.logEvent(
                "Page Load",
                parameters: [
                    "app": "Tamil Lit",
                    "event": "page load",
                    "identifier":"saved-poems-view",
                    "viewName":"Saved Poems View"
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
    
    private func getColorByBook(_ value: String) -> Color {
        if let bookColor = bookManager.books.filter({ $0.title == value }).first?.color {
            return bookColor
        }
        
        return .blue
    }
}

#Preview {
    SavedPoemListView()
}
