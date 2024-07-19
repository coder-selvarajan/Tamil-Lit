//
//  SearchView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 18/07/24.
//

import SwiftUI

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
    @StateObject var vm = SearchViewModel()
    
    
    @State var filteredItems: [String] = []
    @State private var searchText = ""
    
    //    @ObservedObject var vmDict: vmDictionary
    @FocusState private var searchIsFocused: Bool
    
    @State private var searchState: SearchState = .initial
    @State private var searchSubmitSource: SearchSubmitSource = .keyboard
    @State var SearchEditChanged: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.showLoading) private var showLoading
    
    @State private var selectedPoem: Poem? = nil
    @State private var isShowingDetail = false
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            // Search textbox
            HStack {
                TextField("Search words in dictionary...",
                          text: $searchText,
                          onEditingChanged: { editingChanged in
                    SearchEditChanged = editingChanged
                    print("editingChanged: \(editingChanged)")
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
                .onChange(of: searchText) { searchTerm in
                    if SearchEditChanged  { // means the cursor is on the search field
                        searchState = searchText == "" ? .initial : .typing
                    }
                }
                .onSubmit {
                    showLoading(.loading)
                    searchState = .submitted
                    vm.search(searchText)
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
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }
                .padding(.leading, 10)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            //Results
            List {
                if (searchState == .initial) {
                    SwiftUI.Section(header: Text("Recent Searches")) {
                        Text("இனிது")
                            .onTapGesture {
                                searchText = "இனிது"
                                showLoading(.loading)
                                searchState = .submitted
                                vm.search(searchText)
                                showLoading(.success)
                                searchIsFocused = false
                            }
                        Text("துறவு")
                            .onTapGesture {
                                searchText = "துறவு"
                                showLoading(.loading)
                                searchState = .submitted
                                vm.search(searchText)
                                showLoading(.success)
                                searchIsFocused = false
                            }
                        Text("வீரம்")
                            .onTapGesture {
                                searchText = "வீரம்"
                                showLoading(.loading)
                                searchState = .submitted
                                vm.search(searchText)
                                showLoading(.success)
                                searchIsFocused = false
                            }
                    }
                }
                
                if (searchState == .typing) {
                    SwiftUI.Section(header: Text("Suggestions")) {
                        Text("Suggestion one")
                        Text("Suggestion two")
                        Text("Suggestion three")
                    }
                }
                
                if (searchState == .submitted) {
                    ForEach(vm.searchResults.keys.sorted(), id: \.self) { bookname in
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
            if let poem = selectedPoem {
                SimplePoemDetailView(selectedPoem: poem)
            }
        }
        .toolbar {
            ToolbarItem {
                Image(systemName: "gearshape")
            }
        }
        
    }
}

#Preview {
    SearchView()
}
