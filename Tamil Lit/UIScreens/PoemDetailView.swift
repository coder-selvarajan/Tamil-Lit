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
                        VStack(alignment: .leading, spacing: 10) {
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
                        .padding(.bottom, 15)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                    }
                }
                .frame(height: poemViewHieght) //getPoemViewHieght())
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .never))
            }
        }
        .padding(.horizontal, 10)
        .background(colorTheme.opacity(0.35))
        .cornerRadius(10.0)
        .padding(.horizontal, 10)
        .padding(.bottom, paddingSize)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()
//            colorTheme.opacity(0.2).ignoresSafeArea()
            colorTheme.opacity(userSettings.darkMode ? 0.5 : 0.3).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10.0) {
                    HStack(alignment: .top, spacing: 5) {
                        Text("வகை : ")
                            .padding(3)
                            .foregroundStyle(.black)
                            .frame(width: 60)
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
                    .padding(.leading, paddingSize)
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
                            SharePoem(poem: $selectedPoem, explanations: $viewModel.explanations)
                            
                            // Save as image icon
                            PoemScreenshotView(poem: $selectedPoem, 
                                               explanations: $viewModel.explanations,
                                               colorTheme: colorTheme) {
                                alertMessage = "படம் Photo Library-ல்  சேமிக்கப்பட்டது!"
                                showAlert = true
                            }
                        }
                        .padding(.top, -paddingSize)
                        
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
                        .padding(.vertical, paddingSize)
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
                            .foregroundStyle(.black.opacity(0.8))
                            .padding(.horizontal, paddingSize)
                            .padding(.vertical, 15)
                            .padding(.trailing, paddingSize)
                    }
                    .background(.white)
                    .cornerRadius(10.0)
                    .shadow(radius: 10)
                    .padding(.bottom, paddingSize)
                    .padding(.trailing, -paddingSize)
                    
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
//        .navigationTitle(Text(bookName).foregroundStyle(.black))
//        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .onChange(of: selectedPoem, { oldValue, newValue in
            poemBookmarked = vmFavPoem.isPoemBookmarked(newValue)
            viewModel.fetchExplanations(for: newValue)
        })
        .popup(isPresented: $showAlert) {
            Text(alertMessage)
                .padding()
                .background(.white)
                .cornerRadius(15.0)
                .shadow(radius: 15.0)
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
                        .frame(width: 30)
                        .padding(.trailing, 10)
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
                poemViewHieght = (CGFloat(lines.count) * 30.0) + 110.0
            }
            
            poemBookmarked = vmFavPoem.isPoemBookmarked(selectedPoem)
            viewModel.fetchExplanations(for: selectedPoem)
        }
    }
}

//#Preview {
//    PoemDetailView()
//}
