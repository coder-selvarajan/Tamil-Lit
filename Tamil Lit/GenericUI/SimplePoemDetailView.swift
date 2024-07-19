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
    @StateObject private var vm = SinglePoemDetailViewModel()
    
    let colorTheme: Color = Color.gray
    @State var selectedPoem: Poem?
    @State var poemViewHieght: CGFloat = 160.0
    @State var randomPoemPickEnabled: Bool = false
    
    func getCategoryText() -> String {
        guard let selectedPoem = selectedPoem else {
            return ""
        }
        
        if selectedPoem.sectionname != nil {
            return "வகை: \n\(selectedPoem.maincategoryname ?? "")  ›  \(selectedPoem.subcategoryname ?? "")  ›  \(selectedPoem.sectionname ?? "")"
        } else if selectedPoem.subcategoryname != nil {
            return "வகை: \n\(selectedPoem.maincategoryname ?? "")  ›  \(selectedPoem.subcategoryname ?? "")"
        } else {
            return "வகை:  \(selectedPoem.maincategoryname ?? "")"
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
    
    var poemTabView: some View {
        VStack {
            ZStack {
                
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
                .tag(selectedPoem)
                .padding(.bottom, 15)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 10)
                    
            }
        }
        .padding(.horizontal, 10)
        .background(colorTheme.opacity(0.35))
        .cornerRadius(10.0)
        .padding(.horizontal, 10)
        .padding(.bottom, 20)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            colorTheme.opacity(0.2).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10.0) {
                    if !randomPoemPickEnabled {
                        HStack {
                            Text(selectedPoem?.bookname ?? "")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            
                            Image(systemName: "xmark.app.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red.opacity(0.7))
                                .onTapGesture {
                                    presentationMode.wrappedValue.dismiss()
                                }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom, 10)
                        
                        Divider().padding(.bottom)
                    }
                    
                    HStack(spacing: 10) {
                        if selectedPoem?.sectionname == "" {
                            Spacer()
                        }
                        Text("\(getCategoryText())")
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.95))
                        Spacer()
                    }
                    .font(.subheadline)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 20)
                    
                    // Poems in a tab view
                    poemTabView
                    
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
            
            // Random poem - action button
            if randomPoemPickEnabled {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        Button {
                            if let poem = vm.getRandomPoem() {
                                selectedPoem = poem
                                
                                if let poemContent = poem.poem {
                                    let lines = poemContent.components(separatedBy: "\n")
                                    poemViewHieght = (CGFloat(lines.count) * 40.0) + 80.0
                                }
                                
                                vmExplanation.fetchExplanations(for: poem)
                            }
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: "wand.and.rays")
                                    .foregroundColor(.red)
                                    .font(.title3)
                                
                                Text("Next")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                    .padding(.trailing, 10)
                                
                            }
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(10.0)
                        .shadow(radius: 10)
                        .padding(.trailing, -10)
                    }
                }
            }
        }
        .navigationTitle(selectedPoem?.bookname ?? "")
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .onAppear {
            if let selectedPoem = selectedPoem {
                if let poemContent = selectedPoem.poem {
                    let lines = poemContent.components(separatedBy: "\n")
                    poemViewHieght = (CGFloat(lines.count) * 40.0) + 80.0
                }
                
                vmExplanation.fetchExplanations(for: selectedPoem)
            }
        }
    }
}

//#Preview {
//    SimplePoemDetailView()
//}
