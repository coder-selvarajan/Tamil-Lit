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
    
    @StateObject private var viewModel = ExplanationListViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            colorTheme.opacity(0.2).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10.0) {
                    
                    HStack(spacing: 10) {
                        Text("வகை: \(selectedPoem.mainCategory?.title ?? "")  \(selectedPoem.subCategory?.title ?? "")  \(selectedPoem.section?.title ?? "")")
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.95))
                    }
                    .font(.subheadline)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 20)
                    
                    VStack {
                        ZStack {
                            TabView(selection: $selectedPoem) {
                                ForEach(poems, id: \.id) { poem in
                                    VStack(alignment: .leading, spacing: 10) {
                                        Spacer()
                                        Text("பாடல்: \(poem.number)")
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
                            .frame(height: 160)
                            .tabViewStyle(.page)
                            .indexViewStyle(.page(backgroundDisplayMode: .never))
                        }
                    }
                    .padding(.horizontal, 10)
                    .background(colorTheme.opacity(0.35))
                    .cornerRadius(10.0)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 20)
                    
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Button {
                                //
                            } label: {
                                Image(systemName: "bookmark")
                                    .font(.title3)
                                    .foregroundStyle(.black)
                            }

                            Button {
                                //
                            } label: {
                                Image(systemName: "paperplane")
                                    .font(.title3)
                                    .foregroundStyle(.black)
                            }.padding(.horizontal, 10)
                        }
                        .padding(.top, -20)
                        
                        ForEach(viewModel.explanations, id:\.self) { explanation in
                            VStack(alignment: .leading, spacing: 2.0) {
                                if let title = explanation.title, title != "" {
                                    Text("\(title)")
                                        .font(.callout)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black)
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
        }
        .navigationTitle(bookName)
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .onChange(of: selectedPoem, { oldValue, newValue in
            viewModel.fetchExplanations(for: newValue)
        })
        .onAppear {
            viewModel.fetchExplanations(for: selectedPoem)
        }
    }
}

//#Preview {
//    PoemDetailView()
//}
