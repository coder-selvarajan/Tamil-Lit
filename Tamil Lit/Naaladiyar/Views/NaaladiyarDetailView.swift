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
            VStack(spacing: 0) {
                Color.blue
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 190)
                Spacer()
            }
            
            // Custom Buttons
            HStack {
                Button(action: {
                    // Action for back button
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .padding()
                }
                
                Spacer() // Pushes everything to the left and right
                
                Button(action: {
                    // Action for more button
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .padding(.horizontal, 10)
            
            
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
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("#\(poem.number)")
                        .fontWeight(Font.Weight.bold)
                        .foregroundStyle(.white)
                    VStack(alignment: .leading, spacing: 2.0) {
                        Text("\(poem.poem)")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 60)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
//                        Text("Tamil :")
//                            .font(.title3)
//                        Divider().background(.gray)
                        
                        VStack(alignment: .leading, spacing: 2.0) {
                            Text("Meaning :")
                                .font(.callout)
                                .foregroundStyle(.blue)
                            Text("\(poem.meaning)")
                                .font(.body)
                        }.padding(.bottom, 15)
                        
                    } //VStack
                } //Scrollview
            } // VStack
            .padding(.horizontal, 20)
            .padding(.top, 50)
            
        } // ZStack
//        .navigationTitle(chapter.name)
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    NaaladiyarDetailView()
//}
