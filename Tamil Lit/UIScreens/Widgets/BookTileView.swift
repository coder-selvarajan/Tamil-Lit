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
    
//    let poemsRead: Int
//    let totalPoems: Int
//    var progress: Double {
////        return Double(book.poemCount/2) / Double(book.poemCount)
////        Double.random(in: 0...1)
//        var result = Double(bookViewSummary.viewedCount) / Double(bookViewSummary.totalRecords)
//        
//        if result < 1.0 {
//            return Double(bookViewSummary.viewedCount)
//        } else {
//            return result
//        }
//    }
   
    
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
                        .lineLimit(1)
//                        .multilineTextAlignment(.leading)
                    
//                    Spacer()
                    
//                    Text(String(format: "%.0f%% Read", progress * 100))
//                        .font(.caption)
//                        .foregroundColor(book.color.opacity(0.75))
                    
                    
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
                        
                        if themeManager.selectedTheme == ThemeSelection.primary {
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
//                    Text(String(format: "%.0f%% Read", progress * 100))
                    Text(readDisplay)
                        .font(.caption)
                        .foregroundColor(.secondary)
//                        .foregroundColor(book.color.opacity(0.9))
                    
//                    SmallDonutChartView(progress: progress, color: book.color.opacity(0.5))
//                    .padding()
                    
//                    ProgressView(value: progress) {
//                        Text("(\(Int(progress * 100))%)")
//                            .font(.caption)
//                    }
//                    .progressViewStyle(LinearProgressViewStyle())
//                    .frame(width: UIScreen.main.bounds.width * 0.15, height: size15)
//                    .padding([.leading, .bottom], size15)
//                    .tint(book.color.opacity(0.75))
                
                    Spacer()
                }.padding()
                
//                HStack(alignment: .center) {
//                    Image(systemName: "eye")
//                        .font(.caption2)
//                    
//                    Text(" \(book.poemCount/2)")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                    
//                    Spacer()
//                }
//                .foregroundColor(.secondary)
//                .padding([.leading, .bottom])
            }.padding(0)
        }
        .frame(height: 150)
    }
}

struct SmallDonutChartView: View {
    let progress: Double // progress value between 0 and 1
    let color: Color
    let lineWidth: CGFloat = 6
    let size: CGFloat = 40
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 1.0)
                .stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .frame(width: size, height: size)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: size, height: size)
            
            Text(String(format: "%.0f%%", progress * 100))
                .font(.system(size: 10))
                .bold()
        }
    }
}
