//
//  NaaladiyarDetailView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 24/03/24.
//

import SwiftUI

struct NaaladiyarDetailView: View {
    let poem: NaaladiyarPoem
    let category: NaaladiyarCategory
    let subCategory: NaaladiyarSubcategory
    let section: NaaladiyarSection
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.indigo.opacity(0.2).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 10.0) {
                    HStack(spacing: 10) {
                        Text("\(category.category) >")
                            .foregroundStyle(.black.opacity(0.95))
                        Text("\(subCategory.subcategory) >")
                            .foregroundStyle(.black.opacity(0.95))
                        Text("\(section.section)")
                            .fontWeight(.bold)
                            .foregroundStyle(.black.opacity(0.95))
                    }
                    .font(.subheadline)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 20)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("#\(poem.number)")
                            .fontWeight(Font.Weight.bold)
                            .foregroundStyle(.black)
                        VStack(alignment: .leading, spacing: 2.0) {
                            Text("\(poem.poem)")
                                .font(.subheadline)
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.indigo.opacity(0.35))
                    .cornerRadius(10.0)
                    .padding(.bottom)
                    .padding(.horizontal, 10)
                    
                    
                    VStack(alignment: .leading) {
                        //                        Text("Tamil :")
                        //                            .font(.title3)
                        //                        Divider().background(.gray)
                        
                        VStack(alignment: .leading, spacing: 2.0) {
                            Text("Meaning :")
                                .font(.callout)
                                .foregroundStyle(.indigo)
                            Text("\(poem.meaning)")
                                .font(.body)
                        }.padding(.bottom, 15)
                        
                    } //VStack
                    .padding(.horizontal, 20)
                } // VStack
            } //Scrollview
            .padding(.horizontal, 0)
            
        } // ZStack
        //        .navigationTitle(chapter.name)
        //        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    NaaladiyarDetailView()
//}
