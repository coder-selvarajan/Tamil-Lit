//
//  PoemDetailView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import SwiftUI

struct PoemDetailView: View {
    let colorTheme: Color
    let bookName: String
    
    var poems: [Poem] = []
    @State var selectedPoem: Poem
    var mainCategory: String = ""
    var subCategory: String = ""
    var section: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel = ExplanationListViewModel()

    @State var poemViewHieght: CGFloat = 160.0
    
    func getCategoryText() -> String {
        if section != "" {
            return "\(mainCategory) › \(subCategory) › \(section)"
        } else if subCategory != "" {
            return "\(mainCategory) > \(subCategory)"
        } else {
            return "\(mainCategory)"
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
        .padding(.bottom, 20)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            colorTheme.opacity(0.2).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10.0) {
                    
                    HStack(spacing: 10) {
                        if section == "" {
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
                                
                                Divider().background(.gray)
                                    .padding(.vertical)
                            }
                        }
                        
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
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .padding(.trailing, 20)
                    }
                    .background(.white)
                    .cornerRadius(10.0)
                    .shadow(radius: 10)
                    .padding(.bottom, 30)
                    .padding(.trailing, -20)
                    
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationTitle(bookName)
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .onChange(of: selectedPoem, { oldValue, newValue in
            viewModel.fetchExplanations(for: newValue)
        })
        .onAppear {
            if let poemContent = selectedPoem.poem {
                let lines = poemContent.components(separatedBy: "\n")
                poemViewHieght = (CGFloat(lines.count) * 40.0) + 80.0
            }
            
            viewModel.fetchExplanations(for: selectedPoem)
        }
    }
}

//#Preview {
//    PoemDetailView()
//}
