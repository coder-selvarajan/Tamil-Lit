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
    //    case submitted
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

func getColorByBook(_ value: String) -> Color {
    var color: Color = .blue
    
    if value == "திருக்குறள்" {
        color = .blue
    } else if value == "ஆத்திச்சூடி" {
        color =  .teal
    } else if value == "நாலடியார்" {
        color =  .indigo
    } else if value == "இனியவை நாற்பது" {
        color =  .purple.opacity(0.7)
    } else if value == "ஆசாரக் கோவை" {
        color =  .red.opacity(0.6)
    } else if value == "நான்மணிக்கடிகை" {
        color =  .orange.opacity(0.7)
    } else if value == "இன்னா நாற்பது" {
        color =  .brown
    } else if value == "திரிகடுகம்" {
        color =  .gray
    } else if value == "முதுமொழிக் காஞ்சி" {
        color =  .cyan
    } else if value == "பழமொழி நானூறு" {
        color =  Color.green.opacity(0.7)
    }
    
    return color
}

struct SearchView: View {
    @AppStorage("BooksOptedForSearch") private var bookOptionsData: Data = Data()
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
                TextField("வார்த்தைகள்...",
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
                        .foregroundColor(.black)
                }
                .padding()
                .background(.gray.opacity(0.2))
                .cornerRadius(10.0)
//                .padding(.leading, 10)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
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
                    }
                }
                
//                if (searchState == .typing) {
//                    SwiftUI.Section(header: Text("Suggestions")) {
//                        Text("Suggestion one")
//                        Text("Suggestion two")
//                        Text("Suggestion three")
//                    }
//                }
                
                if (searchState == .submitted) {
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
            SimplePoemDetailView(selectedPoem: $selectedPoem, popupMode: true)
        }
        .onAppear(perform: loadBookOptions) // To load book options for search from user-defaults
        .popup(isPresented: $showOptions) {
            BookSelectorView(showModal: $showOptions, booksInfo: $bookOptions) {
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
    SearchView()
}
