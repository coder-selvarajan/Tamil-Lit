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
    @State private var alertMessage: String = ""
    
    @State private var poemBookmarked: Bool = false
    
    func getCategoryText() -> String {
//        guard let selectedPoem = selectedPoem else {
//            return ""
//        }
        
        if selectedPoem.sectionname != nil {
            return "\(selectedPoem.maincategoryname ?? "")  ›  \(selectedPoem.subcategoryname ?? "")  ›  \(selectedPoem.sectionname ?? "")"
        } else if selectedPoem.subcategoryname != nil {
            return "\(selectedPoem.maincategoryname ?? "")  ›  \(selectedPoem.subcategoryname ?? "")"
        } else {
            return "\(selectedPoem.maincategoryname ?? "")"
        }
    }
    
    func getPoemTitle() -> String {
//        guard let selectedPoem = selectedPoem else {
//            return ""
//        }
        
        if selectedPoem.number == 0 {
            return ""
        }
        
        let poemType = selectedPoem.book?.poemType ?? ""
        
        if let title = selectedPoem.title, title != "" {
            return title + ":"
        }
        
        return poemType + ": \(selectedPoem.number)"
    }
    
    var poemScreenshotView: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            HStack(alignment: .top, spacing: 5) {
                Text("நூல் : ")
                    .padding(3)
                    .foregroundStyle(.black)
                    .frame(width: 60)
                    .multilineTextAlignment(.trailing)
                    .background(.white)
                    .cornerRadius(5)
                    .padding(.trailing, 5)
                Text("\(selectedPoem.bookname ?? "")")
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.95))
                Spacer()
            }
            .font(.subheadline)
            .padding(.vertical, 5)
            .padding(.leading, 20)
            .padding(.trailing, 5)
            
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
            .padding(.leading, 20)
            .padding(.trailing, 5)
            
            // Poem view
            VStack(alignment: .leading, spacing: 10) {
                Text("\(getPoemTitle())")
                    .font(.callout)
                    .fontWeight(Font.Weight.semibold)
                    .foregroundStyle(.black)
                
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("\(selectedPoem.poem ?? "")")
                        .font(.subheadline)
                        .fontWeight(Font.Weight.semibold)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .background(colorTheme.opacity(0.5))
            .cornerRadius(10.0)
            .padding(.horizontal, 10)
            
            
            VStack(alignment: .leading) {
                ForEach(vmExplanation.explanations.prefix(3), id:\.self) { explanation in
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
                        
                        Divider().background(.gray)
                            .padding(.vertical)
                    }
                    .padding(.top, 10)
                }
            }.padding()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 40)
        .background(colorTheme.opacity(0.35))
        .frame(width: UIScreen.main.bounds.width)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            colorTheme.opacity(0.2).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10.0) {
                    
                    // Book and Category titles
                    VStack {
                        HStack(alignment: .top, spacing: 5) {
                            Text("நூல் : ")
                                .padding(3)
                                .frame(width: 60)
                                .multilineTextAlignment(.trailing)
                                .background(.white)
                                .cornerRadius(5)
                                .padding(.trailing, 5)
                            Text("\(selectedPoem.bookname ?? "")")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.black.opacity(0.95))
                            Spacer()
                        }
                        .font(.subheadline)
                        .padding(.bottom, 10)
                        .padding(.leading, 20)
                        .padding(.trailing, 5)
                        
                        HStack(alignment: .top, spacing: 5) {
                            Text("வகை : ")
                                .padding(3)
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
                        .padding(.bottom, 10)
                        .padding(.leading, 20)
                        .padding(.trailing, 5)
                    }
                    .padding(.top, 30)
                    .padding(.bottom)
                    
                    // Poem box
                    VStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Spacer()
                            Text("\(getPoemTitle())")
                                .font(.callout)
                                .fontWeight(Font.Weight.semibold)
                                .foregroundStyle(.black)
                            
                            VStack(alignment: .leading, spacing: 2.0) {
                                Text("\(selectedPoem.poem ?? "")")
                                    .font(.subheadline)
                                    .fontWeight(Font.Weight.semibold)
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            Spacer()
                        }
                        .padding(.bottom, 15)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                    }
                    .padding(.horizontal, 10)
                    .background(colorTheme.opacity(0.35))
                    .cornerRadius(10.0)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 20)
                    
                    // Explanation section
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Button {
//                                if let selectedPoem = selectedPoem {
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
//                                }
                            } label: {
                                HStack(spacing: 5) {
                                    Image(systemName: poemBookmarked ? "bookmark.fill" : "bookmark")
                                    Text("சேமி")
                                }
                                .font(.subheadline)
                                .foregroundStyle(.black)
                            }
                            
                            // Share poem icon
                            SharePoem(poem: $selectedPoem, explanations: $vmExplanation.explanations)
                            
                            // Save as image icon
                            Button(action: {
                                let renderer = ImageRenderer(content: poemScreenshotView)
                                if let image = renderer.uiImage {
                                    let imageSaver = ImageSever()
                                    imageSaver.writeToPhotoAlbum(image: image)
                                    
                                    alertMessage = "படம் சேமிக்கப்பட்டது!"
                                    showAlert = true
                                }
                                
//                                let image = self.snapshot()
//                                saveImageToPhotoLibrary(image: image) { success in
//                                    if success {
//                                        alertMessage = "படம் சேமிக்கப்பட்டது!"
//                                        showAlert = true
//                                    } else {
//                                        alertMessage = "Operation failed!"
//                                        showAlert = true
//                                    }
//                                }
                            }) {
                                HStack(spacing: 5) {
                                    Image(systemName: "camera")
                                    Text("படம்")
                                }
                                .font(.subheadline)
                                .foregroundStyle(.black)
                            }
                        }
                        .padding(.top, -20)
                        
                        ForEach(vmExplanation.explanations, id:\.self) { explanation in
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
                                
                                Divider().background(.gray)
                                    .padding(.vertical)
                            }.padding(.top, 10)
                        }
                        
                    }.padding().padding(.bottom, 20)
                }
            }
            
            if popupMode {
                VStack {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "xmark.app.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red.opacity(0.7))
                            .padding(10)
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
        .onChange(of: selectedPoem, { oldValue, newValue in
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
