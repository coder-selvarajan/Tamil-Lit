//
//  KuralDetailView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

struct KuralDetailView: View {
    let kuralList: [Kural]
    @State var selKural: Kural
    
    let section: KuralSection
    let chapterGroup: KuralChapterGroup
    let chapter: KuralChapter
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.blue.opacity(0.2).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10.0) {
                    
                    HStack(spacing: 10) {
                        Text("\(section.name) >")
                            .foregroundStyle(.black.opacity(0.95))
                        Text("\(chapterGroup.name) >")
                            .foregroundStyle(.black.opacity(0.95))
                        Text("\(chapter.name)")
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.95))
                    }
                    .font(.subheadline)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 20)
                    
                    VStack {
                        ZStack {
                            TabView(selection: $selKural) {
                                ForEach(kuralList, id: \.id) { kural in
                                    VStack(alignment: .leading, spacing: 10) {
                                        Spacer()
                                        Text("குறள்: \(kural.Number)")
                                            .font(.callout)
                                            .fontWeight(Font.Weight.semibold)
                                            .foregroundStyle(.black)
                                        
                                        VStack(alignment: .leading, spacing: 2.0) {
                                            Text("\(kural.Line1)")
                                                .font(.subheadline)
                                                .fontWeight(Font.Weight.semibold)
                                                .foregroundStyle(.black)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("\(kural.Line2)")
                                                .font(.subheadline)
                                                .fontWeight(Font.Weight.semibold)
                                                .foregroundStyle(.black)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        
                                        //                                    Divider()
                                        //                                        .overlay(Color.white)
                                        //                                        .padding(.vertical, 10)
                                        //
                                        //                                    VStack(alignment: .leading, spacing: 2.0) {
                                        //                                        Text("\(kural.transliteration1)")
                                        //                                        Text("\(kural.transliteration2)")
                                        //                                    }
                                        //                                    .font(.subheadline)
                                        
                                        Spacer()
                                    }
                                    .tag(kural)
                                    .padding(.bottom, 15)
                                    .frame(maxWidth: .infinity)
                                    //                                .padding()
                                    //.background(.blue.opacity(0.35))
                                    //                    .background(.blue.opacity(0.5))
                                    //.cornerRadius(10.0)
                                    .padding(.horizontal, 10)
                                }
                                
                            }
                            .frame(height: 160)
                            .tabViewStyle(.page)
                            .indexViewStyle(.page(backgroundDisplayMode: .never))
                            
//                            Text("SAVE")
//                                .foregroundStyle(.red)
                            
//                            Image(systemName: "bookmark")
//                                .font(.body)
//                                .foregroundStyle(.white)
//                                .padding([.top, .trailing])
//                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
//                                .offset(x: -5, y: -5)
                                
                        }
                    }
                    .padding(.horizontal, 10)
                    .background(.blue.opacity(0.35))
                    .cornerRadius(10.0)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 20)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Tamil :")
                                .font(.title3)
                            
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
                                    .padding(.horizontal, 10) 
                            }

                            
                            
                        }
                        
                        Divider().background(.gray)
                        
                        VStack(alignment: .leading, spacing: 2.0) {
                            Text("மு.வரதராசன் உரை:")
                                .font(.callout)
                                .foregroundStyle(.blue)
                            Text("\(selKural.mv)")
                                .font(.body)
                        }.padding(.bottom, 15)
                        
                        VStack(alignment: .leading, spacing: 2.0) {
                            Text("சாலமன் பாப்பையா உரை:")
                                .font(.callout)
                                .foregroundStyle(.blue)
                            Text("\(selKural.sp)")
                                .font(.body)
                        }.padding(.bottom, 15)
                        
                        VStack(alignment: .leading, spacing: 2.0) {
                            Text("கலைஞர் உரை:")
                                .font(.callout)
                                .foregroundStyle(.blue)
                            Text("\(selKural.mk)")
                                .font(.body)
                        }
                        .padding(.bottom, 30)
                        
                        
                        
                        Text("English ")
                            .font(.title3)
                        
                        Divider().background(.gray)
                        
                        VStack(alignment: .leading, spacing: 2.0) {
                            Text("Transliteration:")
                                .font(.callout)
                                .foregroundStyle(.blue)
                            Text("\(selKural.transliteration1)")
                                .font(.body)
                            Text("\(selKural.transliteration2)")
                                .font(.body)
                        }.padding(.bottom, 15)
                        
                        VStack(alignment: .leading, spacing: 2.0) {
                            Text("Couplet:")
                                .font(.callout)
                                .foregroundStyle(.blue)
                            Text("\(selKural.couplet)")
                                .font(.body)
                        }.padding(.bottom, 15)
                        
                        VStack(alignment: .leading, spacing: 2.0) {
                            Text("Explanation:")
                                .font(.callout)
                                .foregroundStyle(.blue)
                            Text("\(selKural.explanation)")
                                .font(.body)
                        }.padding(.bottom, 15)
                    } //VStack
                    .padding(.horizontal, 20)
                    
                    VStack{
                        Text(" ")
                    }.frame(height: 50.0)
                } // VStack
            }//Scrollview
            .padding(.horizontal, 0)
        } // ZStack
        .navigationTitle("திருக்குறள்")
        //        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    KuralDetailView()
//}
