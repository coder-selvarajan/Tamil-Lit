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

struct SearchView: View {
    @State var filteredItems: [String] = []
    @State private var searchText = ""
    
//    @ObservedObject var vmDict: vmDictionary
    @FocusState private var searchIsFocused: Bool
    
    @State private var searchState: SearchState = .initial
    @State private var searchSubmitSource: SearchSubmitSource = .keyboard
    @State var SearchEditChanged: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            ScrollView {
                
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
                        //                        vmDict.filterWordList(searchText: searchTerm)
                    }
                    .onSubmit {
                        
                        //                        vmDict.wordsApiResponse = nil
                        //                        vmDict.googleDataDump = nil
                        //                        vmDict.webstersResponse = nil
                        //                        vmDict.tamilResponse = nil
                        //                        vmDict.owlbotResponse = nil
                        
                        searchState = .submitted
                        
                        //                        searchSubmit2FreeApi()
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
                VStack {
                    
                    if (searchState == .initial) {
                        // Recent Search List
                        Group {
                            Text("Thirukural search")
                            Text("Naaladiyar search")
                            Text("Muthumozhikanchi search")
                        }
                    }
                    
                    if (searchState == .typing) {
                        // Recent Search List
                        Group {
                            Text("Suggession one")
                            Text("Suggession two")
                            Text("Suggession three")
                        }
                    }
                    
                    if (searchState == .submitted) {
                        // Recent Search List
                        Group {
                            Text("Resuls from Thirukural")
                            Text("Resuls from Athichudi")
                            Text("Resuls from Pazhamozhi Nanooru")
                        }
                    }
                    
                }
                
            } //Scrollview
            .onAppear {
//                searchHistoryVM.getRecentSearchEntries()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                    /// Anything over 0.5 seems to work
                    self.searchIsFocused = true
                }
            }
            
        } //VStack
        .navigationTitle(Text("பாடல் தேடு"))
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
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
