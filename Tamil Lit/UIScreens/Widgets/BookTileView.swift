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
    @Binding var bookViewSummary: BookViewedSummary
    
    var readDisplay: String {
        
        // If no view count then display none.
        if bookViewSummary.viewedCount == 0 {
            return ""
        }
        
        let result = Double(bookViewSummary.viewedCount) / Double(bookViewSummary.totalRecords)
        
        if result < 0.01 { //if it's less than 1%, show the view count.
            return String(format: "\(bookViewSummary.viewedCount) Read")
        } else {
            return String(format: "%.0f%% Read", result * 100)
        }
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: size10)
                .fill(book.color.opacity(0.2))
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: size10) {
                    Text(book.bannerDisplay)
                        .font(.body.bold())
                        .foregroundStyle(Color("TextColor"))
                        .multilineTextAlignment(.leading)
                    
                    Text(book.subtitle)
                        .font(.footnote)
                        .foregroundStyle(Color("TextColor").opacity(0.7))
                        .lineLimit(1)
                }
                .padding()
                
                Spacer()
            }
            
            if bookDisplayAsGrid {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        if themeManager.selectedTheme == ThemeSelection.colorful {
                            FilterImage(imageName: book.image)
                                .scaledToFit()
                                .frame(height: size70)
                                .opacity(book.title == "திரிகடுகம்" ? 0.8 : 0.9)
                        } else {
                            Image(book.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: size70)
                                .opacity(0.9)
                        }
                        
                    }.padding(0)
                }.padding(0)
            }
            
            
            VStack {
                Spacer()

                HStack(alignment: .center) {
                    Text(readDisplay)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                
                    Spacer()
                }.padding()
            }.padding(0)
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(Text("\(book.title) Tile"))
        .frame(height: size150)
    }
}
