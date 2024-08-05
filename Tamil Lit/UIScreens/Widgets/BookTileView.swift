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
                        .font(.title3)
                        .foregroundStyle(Color("TextColor"))
                        .multilineTextAlignment(.leading)
                    Text(book.subtitle)
                        .font(.footnote)
                        .foregroundStyle(Color("TextColor").opacity(0.7))
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
        }
        .frame(height: 150)
    }
}

