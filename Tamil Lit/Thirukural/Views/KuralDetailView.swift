//
//  KuralDetailView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

struct KuralDetailView: View {
    let kuralList: [Kural]?
    
    let kural: Kural
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
                        TabView {
                            ForEach(kuralList ?? []) { currentKural in
                                VStack(alignment: .leading, spacing: 10) {
                                    Spacer()
                                    Text("#\(currentKural.Number)")
                                        .fontWeight(Font.Weight.bold)
                                        .foregroundStyle(.black)
                                    
                                    VStack(alignment: .leading, spacing: 2.0) {
                                        Text("\(currentKural.Line1)")
                                            .font(.subheadline)
                                            .foregroundStyle(.black)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text("\(currentKural.Line2)")
                                            .font(.subheadline)
                                            .foregroundStyle(.black)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                //                                .padding()
                                //.background(.blue.opacity(0.35))
                                //                    .background(.blue.opacity(0.5))
                                //.cornerRadius(10.0)
                                .padding(.horizontal, 10)
                            }
                            
                        }
                        .frame(height: 150)
                        .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .never))
                    }
                    .padding(.horizontal, 10)
                    .background(.blue.opacity(0.35))
                    .cornerRadius(10.0)
                    .padding(.horizontal, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Tamil :")
                            .font(.title3)
                        Divider().background(.gray)
                        
                        VStack(alignment: .leading, spacing: 2.0) {
                            Text("மு.வரதராசன் உரை:")
                                .font(.callout)
                                .foregroundStyle(.blue)
                            Text("\(kural.mv)")
                                .font(.body)
                        }.padding(.bottom, 15)
                        
                        VStack(alignment: .leading, spacing: 2.0) {
                            Text("சாலமன் பாப்பையா உரை:")
                                .font(.callout)
                                .foregroundStyle(.blue)
                            Text("\(kural.sp)")
                                .font(.body)
                        }.padding(.bottom, 15)
                        
                        VStack(alignment: .leading, spacing: 2.0) {
                            Text("கலைஞர் உரை:")
                                .font(.callout)
                                .foregroundStyle(.blue)
                            Text("\(kural.mk)")
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
                            Text("\(kural.transliteration1)")
                                .font(.body)
                            Text("\(kural.transliteration2)")
                                .font(.body)
                        }.padding(.bottom, 15)
                        
                        VStack(alignment: .leading, spacing: 2.0) {
                            Text("Couplet:")
                                .font(.callout)
                                .foregroundStyle(.blue)
                            Text("\(kural.couplet)")
                                .font(.body)
                        }.padding(.bottom, 15)
                        
                        VStack(alignment: .leading, spacing: 2.0) {
                            Text("Explanation:")
                                .font(.callout)
                                .foregroundStyle(.blue)
                            Text("\(kural.explanation)")
                                .font(.body)
                        }.padding(.bottom, 15)
                    } //VStack
                    .padding(.horizontal, 20)
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
