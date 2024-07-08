//
//  HomeView2.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/05/24.
//

import SwiftUI


struct HomeView: View {
    @Environment(\.showLoading) private var showLoading
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        // Daily poem
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(alignment: .center) {
                                Text("Poem of the day")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Image(systemName: "star")
                                    .padding(.horizontal, 10)
                                    .foregroundStyle(.black)
                                Image(systemName: "info.circle")
                                    .foregroundStyle(.black)
                            }
                            .padding(.bottom)
                            Text("இருள்சேர் இருவினையும் சேரா இறைவன்")
                            Text("பொருள்சேர் புகழ்புரிந்தார் மாட்டு.")
                        }
//                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray5))
//                        .background(Color.black.opacity(0.9))
                        .cornerRadius(8)
                        .padding()
                        
                        VStack (alignment: .leading) {
                            HStack(spacing: 10) {
                                Button {
                                    Task {
                                        showLoading(.loading)
                                        try? await Task.sleep(nanoseconds: 1_000_000_000)
                                        showLoading(.success)
                                    }
                                } label: {
                                    Text(" 🪄 Random Poem") // 🌈
                                        .foregroundStyle(.black)
                                        .padding(10)
                                        .background(.gray.opacity(0.15))
                                        .cornerRadius(10.0)
                                }

                                Button {
                                    Task {
                                        showLoading(.loading)
                                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                                        showLoading(.success)
                                    }
                                } label: {
                                    Text(" ⭐️ Favourites")
                                        .foregroundStyle(.black)
                                        .padding(10)
                                        .background(.gray.opacity(0.15))
                                        .cornerRadius(10.0)
                                }
                                
                                Spacer()
                            }.padding(.horizontal, 20)
                        }
                        
                        // Tiles
                        VStack(spacing: 16) {
                            HStack {
                                
                                Image(systemName: "books.vertical")
                                    .font(.title2)
                                    .padding(.trailing, 5)
                                Text("தமிழ் இலக்கிய நூல்கள்")
                                    .font(.headline)
                                
                                Spacer()
                                Image(systemName: "gearshape")
                            }
                            
                            HStack(spacing: 16) {
                                NavigationLink(value: "Thirukural") {
                                    BookTileView(bookTitle: "திருக்குறள்",
                                                 imageName: "Thiruvalluvar3",
//                                                 iconName: "book",
                                                 footnote: "1330 poems",
                                                 color: Color.blue)
                                }
                                NavigationLink(value: "Athichudi") {
                                    BookTileView(bookTitle: "ஆத்தி சூடி",
                                                 imageName: "Avvaiyar3",
//                                                 iconName: "character.book.closed",
                                                 footnote: "100 proverbs",
                                                 color: Color.teal)
                                }
                            }
                            HStack(spacing: 16) {
                                NavigationLink(value: "Naaladiyar") {
                                    BookTileView(bookTitle: "நாலடியார்",
                                                 imageName: "Jainmonk",
                                                 footnote: "Quatrains",
                                                 color: Color.indigo)
                                }
                                NavigationLink(value: "இனியவை நாற்பது") {
                                    BookTileView(bookTitle: "இனியவை நாற்பது",
                                                 iconName: "text.book.closed",
                                                 footnote: "Epic Poetry",
                                                 color: Color.purple)
                                }
                            }
                            HStack(spacing: 16) {
                                NavigationLink(value: "ஆசாரக் கோவை") {
                                    BookTileView(bookTitle: "ஆசாரக் கோவை",
                                                 iconName: "book",
                                                 footnote: "Sangam Poetry",
                                                 color: Color.red)
                                }
                                NavigationLink(value: "நான்மணிக்கடிகை") {
                                    BookTileView(bookTitle: "நான்மணிக் கடிகை",
                                                 iconName: "text.book.closed",
                                                 footnote: "Epic Poetry",
                                                 color: Color.orange)
                                }
                                
                            }
                            HStack(spacing: 16) {
                                NavigationLink(value: "இன்னா நாற்பது") {
                                    BookTileView(bookTitle: "இன்னா நாற்பது",
                                                 iconName: "book",
                                                 footnote: "Sangam Poetry",
                                                 color: Color.yellow)
                                }
                                NavigationLink(value: "திரிகடுகம்") {
                                    BookTileView(bookTitle: "திரிகடுகம்",
                                                 iconName: "text.book.closed",
                                                 footnote: "Epic Poetry",
                                                 color: Color.green)
                                }
                            }
                        }
                        .padding()
                        
//                        VStack{
//                            Text(" ")
//                        }.frame(height: 50.0)
                        
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
//            .padding(.bottom, 50)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self) { value in
                if value == "Thirukural" {
//                    KuralHomeView()
                    BookHomeView(colorTheme: .blue, bookName: "திருக்குறள்")
                } else if value == "Athichudi" {
                    BookHomeView(colorTheme: .cyan, bookName: "ஆத்திச்சூடி")
//                    AthichudiHomeView()
                } else if value == "Naaladiyar" {
                    NaaladiyarHomeView()
                } else if value == "இனியவை நாற்பது" {
                    BookHomeView(colorTheme: .purple, bookName: "இனியவை நாற்பது")
                } else if value == "ஆசாரக் கோவை" {
                    BookHomeView(colorTheme: .red, bookName: "ஆசாரக் கோவை")
                } else if value == "நான்மணிக்கடிகை" {
                    BookHomeView(colorTheme: .orange, bookName: "நான்மணிக்கடிகை")
                } else if value == "இன்னா நாற்பது" {
                    BookHomeView(colorTheme: .yellow, bookName: "இன்னா நாற்பது")
                } else if value == "திரிகடுகம்" {
                    BookHomeView(colorTheme: .green, bookName: "திரிகடுகம்")
                }
                
                //
                //
                //
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
    var imageName: String?
    var iconName: String = ""
    var footnote: String
    var color: Color = Color.clear
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .fill((color != Color.clear ? color.opacity(0.25) : colors.randomElement()?.opacity(0.25))!)
                .shadow(radius: 5)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(bookTitle)
                        .font(.headline)
                        .foregroundStyle(.black)
                        .fontWeight(Font.Weight.semibold)
                        //.lineLimit(1)
                    Text(footnote)
                        .font(.footnote)
                        .foregroundColor(.black.opacity(0.7))
                }
//                .frame(maxWidth: .infinity)
                .padding()
                
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    if let img = imageName {
                        Image(img)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                            .saturation(0.0)
                            .brightness(0.02)
//                            .contrast(1.0)
//                            .padding(10)
                            .opacity(0.8)
                    }
                    else {
                        Image("book-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .saturation(0.0)
                            .opacity(0.6)
                            .padding()
                        
//                        Image(systemName: iconName)
//                            .font(.title)
//                            .foregroundStyle(.black.opacity(0.35))
//                            .padding()
                    }
                }.padding(0)
            }.padding(0)
        }
        .frame(height: 150)
        
//        ZStack {
//            VStack(alignment: .leading, spacing: 5) {
////                Image(systemName: iconName)
////                    .font(.title2)
//                Text(bookTitle)
//                    .font(.subheadline)
//                    .fontWeight(Font.Weight.semibold)
//                    .lineLimit(1)
//                Text(footnote)
//                    .font(.caption2)
//                    .foregroundColor(.black.opacity(0.7))
//    //                .padding(.bottom)
//            }
//            .foregroundStyle(.black)
//            .padding(20)
//            .frame(maxWidth: .infinity)
//            .background(color != Color.clear ? color.opacity(0.25) : colors.randomElement()?.opacity(0.25))
//            .cornerRadius(10)
//            
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Image(systemName: iconName)
//                        .font(.title2)
//                        .foregroundStyle(.black)
//                        .padding(10)
//                }
//            }
//        }
        
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
