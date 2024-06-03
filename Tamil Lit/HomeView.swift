//
//  HomeView2.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/05/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack {
                        // Daily poem
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(alignment: .center) {
                                Text("Poem of the day")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .padding(.bottom)
                                
                                Spacer()
                                
                                Image(systemName: "info.circle")
                            }
                            Text("இருள்சேர் இருவினையும் சேரா இறைவன்")
                            Text("பொருள்சேர் புகழ்புரிந்தார் மாட்டு.")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding()
                        
                        // Tiles
                        VStack(spacing: 16) {
                            HStack {
                                Text("தமிழ் இலக்கிய நூல்கள்:")
                                    .font(.headline)
                                
                                Spacer()
                                Image(systemName: "gearshape")
                            }
                            
                            HStack(spacing: 16) {
                                NavigationLink(value: "Thirukural") {
                                    BookTileView(bookTitle: "திருக்குறள்",
                                                 iconName: "book",
                                                 footnote: "1330 poems",
                                                 color: Color.blue)
                                }
                                NavigationLink(value: "Athichudi") {
                                    BookTileView(bookTitle: "ஆத்தி சூடி",
                                                 iconName: "character.book.closed",
                                                 footnote: "100 proverbs",
                                                 color: Color.teal)
                                }
                            }
                            HStack(spacing: 16) {
                                NavigationLink(value: "Naaladiyar") {
                                    BookTileView(bookTitle: "நாலடியார்",
                                                 iconName: "book",
                                                 footnote: "Quatrains",
                                                 color: Color.indigo)
                                }
                                BookTileView(bookTitle: "அகநானூறு",
                                             iconName: "text.book.closed",
                                             footnote: "Epic Poetry",
                                             color: Color.purple)
                            }
                            HStack(spacing: 16) {
                                BookTileView(bookTitle: "குறிஞ்சிப்பாட்டு",
                                             iconName: "text.book.closed",
                                             footnote: "Epic Poetry",
                                             color: Color.orange)
                                BookTileView(bookTitle: "புறநானூறு",
                                             iconName: "book",
                                             footnote: "Sangam Poetry",
                                             color: Color.mint)
                            }
                        }
                        .padding()
                        
                        Spacer()
                    }
                }
                
//                // Tab Bar
//                HStack {
//                    Spacer()
//                    TabBarButton(iconName: "house", label: "Home")
//                    Spacer()
//                    TabBarButton(iconName: "star", label: "Favourites")
//                    Spacer()
//                    TabBarButton(iconName: "gearshape", label: "Settings")
//                    Spacer()
//                }
//                .padding(.vertical, 15)
//                .background(Color(.systemGray6))
//                .cornerRadius(15)
//                .padding(.horizontal)
            }
            .padding(.bottom, 50)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self) { value in
                if value == "Thirukural" {
                    KuralHomeView()
                } else if value == "Athichudi" {
                    AthichudiHomeView()
                } else if value == "Naaladiyar" {
                    NaaladiyarHomeView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        // Search Bar
                        HStack {
                            TextField("Search Poems...", text: .constant(""))
                                .padding(.leading, 10)
                        }
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        
                        Image(systemName: "tengesign.circle")
                            .font(.title)
                            .foregroundStyle(.indigo)
                    }
                    .padding(0)
                }
            } // toolbar
        }
    }
}

struct BookTileView: View {
    var colors = [Color.blue, Color.green, Color.red, Color.cyan, Color.indigo, Color.orange, Color.purple, Color.brown, Color.teal, Color.pink, Color.gray, Color.yellow]
    var bookTitle: String
    var iconName: String
    var footnote: String
    var color: Color = Color.clear
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: iconName)
                .font(.title2)
            Text(bookTitle)
                .font(.headline)
            Text(footnote)
                .font(.caption2)
                .foregroundColor(.black.opacity(0.7))
//                .padding(.bottom)
        }
        .foregroundStyle(.black)
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(color != Color.clear ? color.opacity(0.25) : colors.randomElement()?.opacity(0.25))
        .cornerRadius(10)
    }
}

struct TabBarButton: View {
    var iconName: String
    var label: String
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: iconName)
            Text(label)
                .font(.footnote)
        }
    }
}

//struct HomeView2_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView2()
//    }
//}


#Preview {
    HomeView()
}
