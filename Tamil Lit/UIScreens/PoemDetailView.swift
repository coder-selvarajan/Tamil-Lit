//
//  PoemDetailView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI
import PopupView

struct PoemDetailView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var themeManager: ThemeManager
    
    @StateObject private var viewModel = ExplanationListViewModel()
    @StateObject private var vmFavPoem = FavouritePoemViewModel()
    @StateObject private var vmPoemDet = PoemDetailsViewModel()
    
    let book: BookInfo
    var poems: [Poem] = []
    
    @State var selectedPoem: Poem
    @State var poemViewHieght: CGFloat = 160.0
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = "படம் Photo Library-ல்  சேமிக்கப்பட்டது!"
    @State private var poemBookmarked: Bool = false
    @State private var shareThePoem = false
    @State var textReading: Bool = false
    
    @State private var timeElapsed = 0
    @State private var timer: Timer?
    
    
    func getCategoryText() -> String {
        if poems.count > 0 {
            let firstPoem = poems.first!
            
            if firstPoem.sectionname != nil {
                return "\(firstPoem.maincategoryname ?? "")  ›  \(firstPoem.subcategoryname ?? "")  ›  \(firstPoem.sectionname ?? "")"
            } else if firstPoem.subcategoryname != nil {
                return "\(firstPoem.maincategoryname ?? "")  ›  \(firstPoem.subcategoryname ?? "")"
            } else {
                return "\(firstPoem.maincategoryname ?? "")"
            }
        }
        
        return ""
    }
    
    func getPoemTitle(poem: Poem) -> String {
        if poem.number == 0 {
            return ""
        }
        
        let poemType = poem.book?.poemType ?? ""
        
        if let title = poem.title, title != "" {
            return title + ":"
        }
        
        return poemType + ": \(poem.number)"
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            if #available(iOS 16.0, *) {
                if themeManager.selectedTheme == ThemeSelection.primary {
                    book.color.opacity(0.2).ignoresSafeArea()
                }
            }
            
            VStack(alignment: .leading, spacing: size10) {
                // Category strip
                HStack(alignment: .top, spacing: 5) {
                    if themeManager.selectedTheme == .primary {
                        Text("வகை: ")
                            .padding(3)
                            .frame(width: size60)
                            .multilineTextAlignment(.trailing)
                            .background(.white)
                            .cornerRadius(5)
                            .padding(.trailing, 5)
                    } else {
                        Text("வகை: ")
                            .padding(3)
                            .frame(width: size60)
                            .multilineTextAlignment(.trailing)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(5)
                            .padding(.trailing, 5)
                    }
                    
                    Text("\(getCategoryText())")
                        .fontWeight(.bold)
                    Spacer()
                }
                .font(.subheadline)
                .padding(.vertical)
                .padding(.leading, size20)
                .padding(.trailing, 5)
                
                
                // Poems in a tab view
                TabView(selection: $selectedPoem) {
                    ForEach(poems, id: \.id) { poem in
                        ScrollView(Axis.Set.vertical, showsIndicators: false) {
                            VStack {
                                ZStack(alignment: .topTrailing) {
                                    // Poem info
                                    VStack(alignment: .leading, spacing: size10) {
                                        Text("\(getPoemTitle(poem: poem))")
                                            .font(.callout.bold())
                                        
                                        VStack(alignment: .leading, spacing: 2.0) {
                                            Text("\(poem.poem ?? "")")
                                                .font(.body.bold())
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                    .padding()
                                    .padding(.vertical, size5)
                                    .frame(maxWidth: .infinity)
                                    .background(themeManager.selectedTheme == ThemeSelection.primary ? book.color.opacity(0.2) : .gray.opacity(0.2))
                                    .cornerRadius(size10)
                                    .padding(.horizontal, size10)
                                    .padding(.bottom, size10)
                                    
                                    // Text to speech button
                                    SpeakButtonView(textContent: Binding(
                                        get: { PoemHelper.poemText(poem: selectedPoem,
                                                                   explanations: viewModel.explanations) },
                                        set: { newValue in
                                            //
                                        }
                                    )).padding([.trailing, .top], size10)
                                }
                                
                                VStack(alignment: .leading) {
                                    // Action button strip
                                    HStack {
                                        Spacer()
                                        Button {
                                            if poemBookmarked {
                                                if vmFavPoem.removeFavPoem(poem) {
                                                    poemBookmarked = false
                                                    alertMessage = "\(poem.book?.poemType ?? "") நீக்கப்பட்டது!"
                                                    showAlert = true
                                                } else {
                                                    alertMessage = "Operation failed!"
                                                    showAlert = true
                                                }
                                            } else {
                                                if vmFavPoem.saveFavPoem(poem) {
                                                    poemBookmarked = true
                                                    alertMessage = "\(poem.book?.poemType ?? "") சேமிக்கப்பட்டது!"
                                                    showAlert = true
                                                } else {
                                                    alertMessage = "Operation failed!"
                                                    showAlert = true
                                                }
                                            }
                                        } label: {
                                            HStack(spacing: 5) {
                                                Image(systemName: poemBookmarked ? "bookmark.fill" : "bookmark")
                                                Text("சேமி")
                                            }
                                            .font(.subheadline)
                                            .foregroundStyle(Color("TextColor"))
                                        }
                                        
                                        // Share icon
                                        SharePoem(poem: $selectedPoem,
                                                  explanations: $viewModel.explanations)
                                        
                                        // Save as image icon
                                        PoemScreenshotView(poem: $selectedPoem,
                                                           explanations: $viewModel.explanations,
                                                           colorTheme: book.color) {
                                            alertMessage = "படம் Photo Library-ல்  சேமிக்கப்பட்டது!"
                                            showAlert = true
                                        }
                                    }
                                    .padding(.top, -size20)
                                    
                                    // Explanations
                                    VStack {
                                        ForEach(viewModel.getExplanations(for: poem), id:\.self) { explanation in
                                            VStack(alignment: .leading, spacing: 2.0) {
                                                if let title = explanation.title, title != "" {
                                                    Text("\(title): ")
                                                        .textSelection(.enabled)
                                                        .font(.body.bold())
                                                        .padding(.bottom, 5)
                                                }
                                                Text("\(explanation.meaning ?? "")")
                                                    .textSelection(.enabled)
                                                    .font(.body)
                                                
                                                if viewModel.explanations.last != explanation {
                                                    Divider()
                                                        .background(.gray)
                                                        .padding(.vertical)
                                                } else {
                                                    Divider().background(Color.clear)
                                                        .padding(.vertical)
                                                }
                                            }
                                        }
                                    }
                                    .padding(.vertical, size20)
                                    
                                }.padding()
                                
                            }
                            .padding(.bottom)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, size5)
                        }
                        .ignoresSafeArea()
                        .tag(poem)
                        
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
        .onChange(of: selectedPoem, perform: { newValue in
            resetTimer() //for 'viewed' field update
            
            poemBookmarked = vmFavPoem.isPoemBookmarked(newValue)
            viewModel.fetchExplanations(for: newValue)
        })
        .popup(isPresented: $showAlert) {
            Text(alertMessage)
                .padding()
                .background(Color("TextColorWhite"))
                .cornerRadius(size15)
                .shadow(radius: size15)
        } customize: {
            $0
                .type(.floater())
                .position(.top)
                .isOpaque(true)
                .animation(.spring())
                .closeOnTapOutside(true)
                .autohideIn(1.5)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    // Search Bar
                    Image(book.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size30)
                        .padding(.trailing, size10)
                    Text(book.title)
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    
                    Spacer()
                    
                }
                .padding(0)
            }
            
            ToolbarItem {
                Button {
                    navigationManager.isRootActive = false
                    navigationManager.activeBook.keys.forEach { navigationManager.activeBook[$0] = false }
                } label: {
                    HStack(alignment: .top, spacing: 5) {
                        Image(systemName: "house")
                            .font(.caption2)
                        Text("Home")
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color("TextColor"))
                    .padding(.vertical, 5)
                    .padding(.horizontal, size10)
                    .background(themeManager.selectedTheme == .primary ? book.color.opacity(0.3) : .gray.opacity(0.2))
                    .cornerRadius(8)
                }
            }
        }
        .onAppear {
            poemBookmarked = vmFavPoem.isPoemBookmarked(selectedPoem)
            viewModel.fetchExplanations(for: selectedPoem)
            
            startTimer() //for updating 'viewed' state
        }
        .onDisappear {
            timer?.invalidate()
        }
        .customFontScaling()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            timeElapsed += 1
            if timeElapsed >= 5 {
                vmPoemDet.updatePoemViewedStatus(for: selectedPoem)
                timer?.invalidate() // Stop the timer after updating
            }
        }
    }
    
    private func resetTimer() {
        timeElapsed = 0
        timer?.invalidate()
        startTimer()
    }
    
}

//#Preview {
//    PoemDetailView()
//}
