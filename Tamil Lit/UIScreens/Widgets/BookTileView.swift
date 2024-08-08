//
//  BookTileView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 03/08/24.
//

import SwiftUI

struct BookTileView: View {
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var themeManager: ThemeManager
    
    @Binding var book: BookInfo
    @Binding var bookDisplayAsGrid: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: size10)
                .fill(book.color.opacity(0.2))
            
//                .overlay(
//                    RoundedRectangle(cornerRadius: size10)
//                        .stroke(Color.cyan, lineWidth: 1)
//                )
//                .fill(userSettings.darkMode ? color.opacity(0.45) : color.opacity(0.25))
//                .background(RoundedRectangle(cornerRadius: size10).fill(Color.white))
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: size10) {
                    Text(book.bannerDisplay)
                        .font(.body.bold())
                        .foregroundStyle(Color("TextColor"))
                        .multilineTextAlignment(.leading)
                    
//                    Text("\(book.poemCount/2)/\(book.poemCount) read")
//                        .font(.footnote)
//                        .foregroundStyle(Color("TextColor").opacity(0.7))
//                        .multilineTextAlignment(.leading)
                    
                    Text(book.subtitle)
                        .font(.footnote)
                        .foregroundStyle(Color("TextColor").opacity(0.7))
                        .multilineTextAlignment(.leading)
                    
//                    HStack {
//                        Text("10 viewed")
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//                        
//                        Spacer()
//                    }.padding(0)
                }
                .padding()
                
                Spacer()
            }
            
            if bookDisplayAsGrid {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        Image(book.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                            .saturation(themeManager.selectedTheme == ThemeSelection.primary ?  0.1 : 1.0)
                            .opacity(0.9)
                        
                    }.padding(0)
                }.padding(0)
            }
            
            VStack {
                Spacer()
                HStack(alignment: .center) {
                    Image(systemName: "eye")
                        .font(.caption2)
                    
                    Text(" \(book.poemCount/2)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .foregroundColor(.secondary)
                .padding([.leading, .bottom])
            }.padding(0)
        }
        .frame(height: 150)
    }
}

