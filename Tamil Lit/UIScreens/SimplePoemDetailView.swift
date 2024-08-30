//
//  SimplePoemDetailView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 19/07/24.
//

import SwiftUI
import PopupView

struct SimplePoemDetailView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var vmExplanation = ExplanationListViewModel()
    @StateObject private var vmFavPoem = SavedPoemViewModel()
    @StateObject private var vmPoemDet = PoemDetailsViewModel()
    
    let colorTheme: Color = Color.gray
    @Binding var selectedPoem: Poem
    @State var popupMode: Bool = false
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @State private var poemBookmarked: Bool = false
    
    @State private var timeElapsed = 0
    @State private var timer: Timer?
    
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
    
    func getMeaningsForSpeech() -> [SpeechContent]? {
        var speechContent: [SpeechContent] = []
        
        var content: String = getPoemTitle() + ". \n" + (selectedPoem.poem ?? "")
        content = content.replacingOccurrences(of: ":", with: ". \n")
        
        speechContent.append(SpeechContent(title: selectedPoem.book?.poemType ?? "", content: content))
        
        vmExplanation.explanations.forEach { explanation in
            if let title = explanation.title, let meaning = explanation.meaning {
                speechContent.append(SpeechContent(title: title, content: title + ". \n" + meaning))
            }
        }
        
        return speechContent.count > 0 ? speechContent : nil
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: size10) {
                    
                    // Book and Category titles
                    VStack {
                        HStack(alignment: .top, spacing: 5) {
                            if themeManager.selectedTheme == .colorful {
                                Text("நூல்: ")
                                    .padding(3)
                                    .frame(width: size60)
                                    .multilineTextAlignment(.trailing)
                                    .background(.white)
                                    .cornerRadius(5)
                                    .padding(.trailing, 5)
                            } else {
                                Text("நூல்: ")
                                    .padding(3)
                                    .frame(width: size60)
                                    .multilineTextAlignment(.trailing)
                                    .background(.gray.opacity(0.2))
                                    .cornerRadius(5)
                                    .padding(.trailing, 5)
                            }
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
                            if themeManager.selectedTheme == .colorful {
                                Text("வகை: ")
                                    .padding(3)
                                    .frame(minWidth: size60)
                                    .multilineTextAlignment(.trailing)
                                    .background(.white)
                                    .cornerRadius(5)
                                    .padding(.trailing, 5)
                            } else {
                                Text("வகை: ")
                                    .padding(3)
                                    .frame(minWidth: size60)
                                    .multilineTextAlignment(.trailing)
                                    .background(.gray.opacity(0.2))
                                    .cornerRadius(5)
                                    .padding(.trailing, 5)
                            }
                            
                            
                            Text("\(getCategoryText())")
                                .fontWeight(.bold)
                                .foregroundStyle(Color("TextColor").opacity(0.95))
                            Spacer()
                        }
//                        .font(.subheadline)
                        .padding(.bottom, size10)
                        .padding(.leading, size20)
                        .padding(.trailing, 5)
                    }
                    .padding(.top, size30)
                    .padding(.bottom)
                    
                    // Poem box
                    ZStack(alignment: .topTrailing) {
                        VStack(alignment: .leading, spacing: size10) {
                            Text("\(getPoemTitle())")
                                .font(.callout.bold())
                            
                            VStack(alignment: .leading, spacing: 2.0) {
                                Text("\(selectedPoem.poem ?? "")")
                                    .font(.body.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .padding(.vertical, size5)
                        .frame(maxWidth: .infinity)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(size10)
                        .padding(.horizontal, size10)
                        .padding(.bottom, size10)
                        
                        // Text to speech button
                        SpeakButtonView(textContent: Binding(
                            get: { PoemHelper.poemText(poem: selectedPoem,
                                                       explanations: vmExplanation.explanations) },
                            set: { newValue in
                                //
                            }
                        ), subContentList: Binding(
                            get: { getMeaningsForSpeech() },
                            set: { newValue in
                                //
                            }
                        ))
                        .padding([.trailing, .top], size10)
                    }
                    
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
                                        alertMessage = "Operation failed❗️"
                                        showAlert = true
                                    }
                                } else {
                                    if vmFavPoem.saveFavPoem(selectedPoem) {
                                        poemBookmarked = true
                                        alertMessage = "\(selectedPoem.book?.poemType ?? "") சேமிக்கப்பட்டது!"
                                        showAlert = true
                                    } else {
                                        alertMessage = "Operation failed❗️"
                                        showAlert = true
                                    }
                                }
                            } label: {
                                HStack(spacing: 5) {
                                    Image(systemName: poemBookmarked ? "bookmark.fill" : "bookmark")
                                    Text("சேமி")
                                }
                                .accessibilityElement(children: .combine)
                                .accessibilityAddTraits(.isButton)
                                .accessibilityLabel(Text("சேமி - \((selectedPoem.poem ?? "").prefix(25))"))
                                .accessibilityIdentifier("சேமி - \(selectedPoem.bookname ?? "") - \(selectedPoem.number)")
                                .font(.subheadline)
                                .foregroundStyle(Color("TextColor"))
                            }
                            
                            // Share poem icon
                            SharePoem(poem: $selectedPoem,
                                      explanations: $vmExplanation.explanations)
                            
                            // Save as image icon
                            PoemScreenshotView(poem: $selectedPoem,
                                               explanations: $vmExplanation.explanations,
                                               colorTheme: colorTheme) { success in
                                if success {
                                    alertMessage = "படம் Photo Library-ல் சேமிக்கப்பட்டது!"
                                } else {
                                    alertMessage = "படம் சேமிக்க இயலவில்லை❗️ \nCheck 'Photo Library' access."
                                }
                                showAlert = true
                            }
                        }
                        .padding(.top, -size20)
                        
                        VStack {
                            ExplanationView(explanations: vmExplanation.explanations)
                        }
                        .padding(.bottom, size20)
                        .padding(.vertical, size20)
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
            PopupContentView(alertMessage: $alertMessage)
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
            resetTimer() //for 'viewed' field update

            poemBookmarked = vmFavPoem.isPoemBookmarked(newValue)
            vmExplanation.fetchExplanations(for: newValue)
        })
        .onAppear {
            poemBookmarked = vmFavPoem.isPoemBookmarked(selectedPoem)
            vmExplanation.fetchExplanations(for: selectedPoem)
            
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
//    SimplePoemDetailView()
//}
