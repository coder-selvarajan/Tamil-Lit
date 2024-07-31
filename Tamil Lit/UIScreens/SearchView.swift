//
//  SearchView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 18/07/24.
//

import SwiftUI
import PopupView

enum SearchState {
    case initial
    case typing
    case submitted
}

enum SearchSubmitSource {
    case history
    case wordlist
    case keyboard
}

struct ClearButton: ViewModifier
{
    @Binding var text: String
    @FocusState var searchIsFocused: Bool
    public func body(content: Content) -> some View
    {
        ZStack(alignment: .trailing)
        {
            content
            
            if !text.isEmpty
            {
                Button(action:
                        {
                    self.text = ""
                    self.searchIsFocused = true
                })
                {
                    Image(systemName: "xmark")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                        .font(.headline)
                }
                .padding(.trailing, 3)
            }
        }
    }
}

extension String {
    func highlight(_ term: String, with color: Color = .yellow.opacity(0.4)) -> AttributedString {
        var attributedString = AttributedString(self)
        
        if let range = attributedString.range(of: term, options: .caseInsensitive) {
            attributedString[range].backgroundColor = color
        }
        
        return attributedString
    }
}

struct SearchView: View {
    @AppStorage("BooksOptedForSearch") private var bookOptionsData: Data = Data()
    @EnvironmentObject var userSettings: UserSettings
    
    @State private var bookOptions: [BookInfo] = []
    
    @StateObject var vm = SearchViewModel()
    
    @State var filteredItems: [String] = []
    @State private var searchText = ""
    
    @FocusState private var searchIsFocused: Bool
    
    @State private var searchState: SearchState = .initial
    @State private var searchSubmitSource: SearchSubmitSource = .keyboard
    @State var SearchEditChanged: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.showLoading) private var showLoading
    
    @State private var selectedPoem: Poem? = nil
    @State private var isShowingDetail = false
    
    @State private var showOptions = false
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            // Search textbox
            HStack {
                TextField("தமிழில் தேடவும்...",
                          text: $searchText,
                          onEditingChanged: { editingChanged in
                    SearchEditChanged = editingChanged
                })
                .modifier(ClearButton(text: $searchText, searchIsFocused: _searchIsFocused))
                .font(.headline)
                .autocapitalization(UITextAutocapitalizationType.none)
                .padding(.horizontal, 15)
                .padding(.vertical, 15)
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
                .focused($searchIsFocused)
                .submitLabel(SubmitLabel.search)
                .disableAutocorrection(true)
                .onChange(of: searchText) {
                    if SearchEditChanged  { // means the cursor is on the search field
                        searchState = searchText == "" ? .initial : .typing
                    }
                }
                .onSubmit {
                    showLoading(.loading)
                    searchState = .submitted
                    vm.search(searchText, bookOptions: bookOptions)
                    showLoading(.success)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            searchIsFocused = false
                        }
                    }
                }
                
                Button {
                    showOptions = true
                } label: {
                    Image(systemName: "checklist")
                        .foregroundColor(Color("TextColor"))
                }
                .padding()
                .background(.gray.opacity(0.2))
                .cornerRadius(10.0)
//                .padding(.leading, 10)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            //Results
            List {
                if (searchState == .initial) {
                    SwiftUI.Section(header: Text("Recent Searches")) {
                        ForEach(vm.getRecentSearch(), id: \.self) { recentText in
                            HStack {
                                Text(recentText)
                                Spacer()
                            }
                            .onTapGesture {
                                searchText = recentText
                                showLoading(.loading)
                                searchState = .submitted
                                vm.search(searchText, bookOptions: bookOptions)
                                showLoading(.success)
                                searchIsFocused = false
                            }
                        }
                        if vm.getRecentSearch().count == 0 {
                            Text("No search yet!")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    if vm.getRecentSearch().count <= 2 {
                        NavigationLink(destination: TamilKeyboardInstructionView()) {
                            HStack {
                                Text("How to enable Tamil keyboard?")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                                    .padding(.top, 5)
                                    .padding(.bottom, 10)
                                
                                Spacer()
                            }
                        }
                    }
                }
                
                if (searchState == .submitted) {
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
                            ForEach(vm.searchResults[bookname] ?? [], id: \.self) { poem in
                                VStack(alignment: .leading) {
                                    if let title = poem.title, title != "" {
                                        Text(title.highlight(searchText))
                                            .font(.headline)
                                    }
                                    if let poemText = poem.poem {
                                        Text(poemText.highlight(searchText))
                                            
                                    }
                                }
                                .onTapGesture {
                                    selectedPoem = poem
                                    isShowingDetail = true
                                }
                            }
                        }
                    }
                }
                
                
            }
            .listStyle(InsetGroupedListStyle())
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                    self.searchIsFocused = true
                }
            }
            
            
            
        } // VStack
        .navigationTitle(Text("பாடல் தேடு"))
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .sheet(isPresented: $isShowingDetail) {
            if selectedPoem != nil {
                SimplePoemDetailView(selectedPoem: Binding($selectedPoem)!, popupMode: true)
            }
        }
        .onAppear(perform: loadBookOptions) // To load book options for search from user-defaults
        .popup(isPresented: $showOptions) {
            let titleString = "Books to include for **Search** : "
            let attributedTitle = try! AttributedString(markdown: titleString)
            
            BookSelectorView(showModal: $showOptions, 
                             booksInfo: $bookOptions,
                             title: attributedTitle) {
                // This will be called for each book selection/deselection
                saveBookOptions()
            }
        } customize: {
            $0
                .type(.floater())
                .position(.center)
                .animation(.spring())
                .closeOnTapOutside(true)
                .closeOnTap(false)
//                .backgroundColor(Color("TextColor").opacity(0.5))
                .backgroundColor(userSettings.darkMode ? .white.opacity(0.25) : .black.opacity(0.65))
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
    SearchView()
}
