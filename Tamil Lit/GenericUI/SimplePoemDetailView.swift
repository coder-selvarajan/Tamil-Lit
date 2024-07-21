//
//  SimplePoemDetailView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 19/07/24.
//

import SwiftUI

struct SimplePoemDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var vmExplanation = ExplanationListViewModel()
    
    let colorTheme: Color = Color.gray
    @Binding var selectedPoem: Poem?
    @State var popupMode: Bool = false
    
    func getCategoryText() -> String {
        guard let selectedPoem = selectedPoem else {
            return ""
        }
        
        if selectedPoem.sectionname != nil {
            return "\(selectedPoem.maincategoryname ?? "")  ›  \(selectedPoem.subcategoryname ?? "")  ›  \(selectedPoem.sectionname ?? "")"
        } else if selectedPoem.subcategoryname != nil {
            return "\(selectedPoem.maincategoryname ?? "")  ›  \(selectedPoem.subcategoryname ?? "")"
        } else {
            return "\(selectedPoem.maincategoryname ?? "")"
        }
    }
    
    func getPoemTitle() -> String {
        guard let selectedPoem = selectedPoem else {
            return ""
        }
        
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
                            Text("\(selectedPoem?.bookname ?? "")")
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
                                Text("\(selectedPoem?.poem ?? "")")
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
                                //
                            } label: {
                                HStack(spacing: 5) {
                                    Image(systemName: "bookmark")
                                    Text("சேமி")
                                }
                                .font(.subheadline)
                                .foregroundStyle(.black)
                            }

                            Button {
                                //
                            } label: {
                                HStack(spacing: 5) {
                                    Image(systemName: "paperplane")
                                    Text("பகிர்")
                                }
                                .font(.subheadline)
                                .foregroundStyle(.black)
                            }.padding(.leading, 10)
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
                            }
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
        .onChange(of: selectedPoem, { oldValue, newValue in
            if let poem = newValue {
                vmExplanation.fetchExplanations(for: poem)
            }
        })
        .onAppear {
            if let selectedPoem = selectedPoem {
                vmExplanation.fetchExplanations(for: selectedPoem)
            }
        }
    }
}

//#Preview {
//    SimplePoemDetailView()
//}
