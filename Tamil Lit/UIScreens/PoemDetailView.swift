//
//  PoemDetailView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI
import PopupView

struct PoemDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userSettings: UserSettings
    
    @StateObject private var viewModel = ExplanationListViewModel()
    @StateObject private var vmFavPoem = FavouritePoemViewModel()
    
    let colorTheme: Color
    let bookName: String
    var poems: [Poem] = []
    
    @State var selectedPoem: Poem
    @State var poemViewHieght: CGFloat = 160.0
    
//    @State private var showAlert: (Bool, String) = (false, "")
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = "படம் Photo Library-ல்  சேமிக்கப்பட்டது!"
    
    @State private var poemBookmarked: Bool = false
    
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
    
    func getPoemTitle() -> String {
        if selectedPoem.number == 0 {
            return ""
        }
        
        let poemType = selectedPoem.book?.poemType ?? ""
        
        if let title = selectedPoem.title, title != "" {
            return title + ":"
        }
        
        return poemType + ": \(selectedPoem.number)"
    }
    
    var poemTabView: some View {
        VStack {
            ZStack {
                TabView(selection: $selectedPoem) {
                    ForEach(poems, id: \.id) { poem in
                        VStack(alignment: .leading, spacing: size10) {
                            Spacer()
                            Text("\(getPoemTitle())")
                                .font(.callout)
                                .fontWeight(Font.Weight.semibold)
                                .foregroundStyle(.black)
                            
                            VStack(alignment: .leading, spacing: 2.0) {
                                Text("\(poem.poem ?? "")")
                                    .font(.subheadline)
                                    .fontWeight(Font.Weight.semibold)
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            Spacer()
                        }
                        .tag(poem)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, size10)
                    }
                }
                .frame(height: poemViewHieght) //getPoemViewHieght())
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .never))
            }
        }
        .padding(.horizontal, size10)
        .background(colorTheme.opacity(0.35))
        .cornerRadius(size10)
        .padding(.horizontal, size10)
        .padding(.bottom, size20)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
//            Color.white.ignoresSafeArea()
//            colorTheme.opacity(0.2).ignoresSafeArea()
            colorTheme.opacity(userSettings.darkMode ? 0.5 : 0.3).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: size10) {
                    HStack(alignment: .top, spacing: 5) {
                        Text("வகை : ")
                            .padding(3)
                            .foregroundStyle(.black)
                            .frame(width: size60)
                            .multilineTextAlignment(.trailing)
                            .background(.white)
                            .cornerRadius(5)
                            .padding(.trailing, 5)
                        Text("\(getCategoryText())")
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.95))
                        Spacer()
                    }
                    .font(.subheadline)
                    .padding(.vertical)
                    .padding(.leading, size20)
                    .padding(.trailing, 5)
                    
                    
                    // Poems in a tab view
                    poemTabView
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Button {
                                if poemBookmarked {
                                    if vmFavPoem.removeFavPoem(selectedPoem) {
                                        poemBookmarked = false
                                        alertMessage = "\(selectedPoem.book?.poemType ?? "") நீக்கப்பட்டது!"
                                        showAlert = true
                                    } else {
                                        alertMessage = "Operation failed!"
                                        showAlert = true
                                    }
                                } else {
                                    if vmFavPoem.saveFavPoem(selectedPoem) {
                                        poemBookmarked = true
                                        alertMessage = "\(selectedPoem.book?.poemType ?? "") சேமிக்கப்பட்டது!"
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
                                .foregroundStyle(.black)
                            }

                            // Share icon
                            SharePoem(poem: $selectedPoem, 
                                      explanations: $viewModel.explanations,
                                      tintColor: .black)
                            
                            // Save as image icon
                            PoemScreenshotView(poem: $selectedPoem, 
                                               explanations: $viewModel.explanations,
                                               iconTintColor: .black,
                                               colorTheme: colorTheme) {
                                alertMessage = "படம் Photo Library-ல்  சேமிக்கப்பட்டது!"
                                showAlert = true
                            }
                        }
                        .padding(.top, -size20)
                        
                        VStack {
                            ForEach(viewModel.explanations, id:\.self) { explanation in
                                VStack(alignment: .leading, spacing: 2.0) {
                                    if let title = explanation.title, title != "" {
                                        Text("\(title): ")
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.black)
                                            .padding(.bottom, 5)
                                    }
                                    Text("\(explanation.meaning ?? "")")
                                        .font(.body)
                                        .foregroundStyle(.black)
                                    
                                    if viewModel.explanations.last != explanation {
                                        Divider().background(.gray)
                                            .padding(.vertical)
                                    } else {
                                        Divider().background(Color.clear)
                                            .padding(.vertical)
                                    }
                                }
                            }
                        }
                        .padding(.vertical, size20)
//                        .padding(.bottom, paddingSize)
                        
                    }.padding()
                }
            }
            
            // Home Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Button {
                        // Go to home page
//                        print(navigationPath.count)
                        //                            navigationPath.removeAll()
                        //                            presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "house.fill")
                            .font(.title3)
                            .foregroundStyle(Color("TextColor").opacity(0.8))
                            .padding(.horizontal, size20)
                            .padding(.vertical)
                            .padding(.trailing, size20)
                    }
                    .background(Color("TextColorWhite"))
                    .cornerRadius(size10)
                    .shadow(radius: size10)
                    .padding(.bottom, size30)
                    .padding(.trailing, -size20)
                    
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
//        .navigationTitle(Text(bookName).foregroundStyle(.black))
//        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .onChange(of: selectedPoem, perform: { newValue in
            poemBookmarked = vmFavPoem.isPoemBookmarked(newValue)
            viewModel.fetchExplanations(for: newValue)
        })
        .popup(isPresented: $showAlert) {
            Text(alertMessage)
                .padding()
                .background(.white)
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
                    Image("Thiruvalluvar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: size30)
                        .padding(.trailing, size10)
                    Text(bookName)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                }
                .padding(0)
            }
        }
        .onAppear {
            if let poemContent = selectedPoem.poem {
                let lines = poemContent.components(separatedBy: "\n")
                poemViewHieght = (CGFloat(lines.count) * size30) + size110
            }
            
            poemBookmarked = vmFavPoem.isPoemBookmarked(selectedPoem)
            viewModel.fetchExplanations(for: selectedPoem)
        }
    }
}

//#Preview {
//    PoemDetailView()
//}
