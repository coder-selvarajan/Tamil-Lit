//
//  SimplePoemDetailView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 19/07/24.
//

import SwiftUI
import PopupView

struct SimplePoemDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var vmExplanation = ExplanationListViewModel()
    @StateObject private var vmFavPoem = FavouritePoemViewModel()
    
    let colorTheme: Color = Color.gray
    @Binding var selectedPoem: Poem
    @State var popupMode: Bool = false
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = "படம் Photo Library-ல்  சேமிக்கப்பட்டது!"
    
    @State private var poemBookmarked: Bool = false
    
    func getCategoryText() -> String {
        if selectedPoem.sectionname != nil {
            return "\(selectedPoem.maincategoryname ?? "")  ›  \(selectedPoem.subcategoryname ?? "")  ›  \(selectedPoem.sectionname ?? "")"
        } else if selectedPoem.subcategoryname != nil {
            return "\(selectedPoem.maincategoryname ?? "")  ›  \(selectedPoem.subcategoryname ?? "")"
        } else {
            return "\(selectedPoem.maincategoryname ?? "")"
        }
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
    
    var body: some View {
        ZStack(alignment: .top) {
            colorTheme.opacity(0.2).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: size10) {
                    
                    // Book and Category titles
                    VStack {
                        HStack(alignment: .top, spacing: 5) {
                            Text("நூல் : ")
                                .padding(3)
                                .frame(width: size60)
                                .multilineTextAlignment(.trailing)
                                .background(Color("TextColorWhite"))
                                .cornerRadius(5)
                                .padding(.trailing, 5)
                            Text("\(selectedPoem.bookname ?? "")")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(Color("TextColor").opacity(0.95))
                            Spacer()
                        }
                        .font(.subheadline)
                        .padding(.bottom, size10)
                        .padding(.leading, size20)
                        .padding(.trailing, 5)
                        
                        HStack(alignment: .top, spacing: 5) {
                            Text("வகை : ")
                                .padding(3)
                                .frame(width: size60)
                                .multilineTextAlignment(.trailing)
                                .background(Color("TextColorWhite"))
                                .cornerRadius(5)
                                .padding(.trailing, 5)
                            Text("\(getCategoryText())")
                                .fontWeight(.bold)
                                .foregroundStyle(Color("TextColor").opacity(0.95))
                            Spacer()
                        }
                        .font(.subheadline)
                        .padding(.bottom, size10)
                        .padding(.leading, size20)
                        .padding(.trailing, 5)
                    }
                    .padding(.top, size30)
                    .padding(.bottom)
                    
                    // Poem box
                    VStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Spacer()
                            Text("\(getPoemTitle())")
                                .font(.callout)
                                .fontWeight(Font.Weight.semibold)
                                .foregroundStyle(Color("TextColor"))
                            
                            VStack(alignment: .leading, spacing: 2.0) {
                                Text("\(selectedPoem.poem ?? "")")
                                    .font(.subheadline)
                                    .fontWeight(Font.Weight.semibold)
                                    .foregroundStyle(Color("TextColor"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            Spacer()
                        }
                        .padding(.bottom)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, size10)
                    }
                    .padding(.horizontal, size10)
                    .background(colorTheme.opacity(0.35))
                    .cornerRadius(size10)
                    .padding(.horizontal, size10)
                    .padding(.bottom, size20)
                    
                    // Explanation section
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
                                .foregroundStyle(Color("TextColor"))
                            }
                            
                            // Share poem icon
                            SharePoem(poem: $selectedPoem, 
                                      explanations: $vmExplanation.explanations,
                                      tintColor: Color("TextColor"))
                            
                            // Save as image icon
                            PoemScreenshotView(poem: $selectedPoem,
                                               explanations: $vmExplanation.explanations,
                                               iconTintColor: Color("TextColor"),
                                               colorTheme: colorTheme) {
                                alertMessage = "படம் Photo Library-ல்  சேமிக்கப்பட்டது!"
                                showAlert = true
                            }
                        }
                        .padding(.top, -size20)
                        
                        VStack {
                            ForEach(vmExplanation.explanations, id:\.self) { explanation in
                                VStack(alignment: .leading, spacing: 2.0) {
                                    if let title = explanation.title, title != "" {
                                        Text("\(title): ")
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color("TextColor"))
                                            .padding(.bottom, 5)
                                    }
                                    Text("\(explanation.meaning ?? "")")
                                        .font(.body)
                                    
                                    if vmExplanation.explanations.last != explanation {
                                        Divider().background(.gray)
                                            .padding(.vertical)
                                    } else {
                                        Divider().background(Color.clear)
                                            .padding(.vertical)
                                    }
                                }
                            }
                        }
                        .padding(.top, size20)
                        
                    }
                    .padding(size20)
                    .padding(.bottom, size20)
                }
            }
            
            if popupMode {
                VStack {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "xmark.app.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red.opacity(0.9))
                            .padding(size10)
                            .padding(.top, 5)
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                    
                    Spacer()
                }
            }
        }
        .popup(isPresented: $showAlert) {
            Text("\(alertMessage)")
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
        .onChange(of: selectedPoem, perform: { newValue in
//            if let poem = newValue {
                poemBookmarked = vmFavPoem.isPoemBookmarked(newValue)
                vmExplanation.fetchExplanations(for: newValue)
//            }
        })
        .onAppear {
//            if let selectedPoem = selectedPoem {
                poemBookmarked = vmFavPoem.isPoemBookmarked(selectedPoem)
                vmExplanation.fetchExplanations(for: selectedPoem)
//            }
        }
    }
}

//#Preview {
//    SimplePoemDetailView()
//}
