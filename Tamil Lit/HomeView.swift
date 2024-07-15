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
//                        // Search Bar
//                        HStack {
//                            TextField("பாடல் தேடுக...", text: .constant(""))
//                                .padding(.leading, 10)
//                        }
//                        .padding(10)
//                        .background(Color(.systemGray5))
//                        .cornerRadius(10)
//                        .padding(.horizontal)
//                        .padding(.top, 10)
                        
                        // Daily poem
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(alignment: .center) {
                                Image(systemName: "deskclock")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                
                                Text("தினம் ஒரு பாடல்:")
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
                        
                        // Action Section
                        VStack (alignment: .leading) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    Button {
                                        Task {
                                            showLoading(.loading)
                                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                                            showLoading(.success)
                                        }
                                    } label: {
                                        HStack(alignment: .top) {
                                            Image(systemName: "wand.and.stars")
                                                .font(.headline)
                                                .foregroundColor(.pink)
                                            VStack(alignment: .leading) {
                                                Text("ஏதோ ஒரு பாடல்")
                                                    .lineLimit(1)
                                                    .foregroundStyle(.black)
                                                Text("(Random Poem)")
                                                    .font(.footnote)
                                                    .foregroundStyle(.gray)
                                            }
                                        }
                                        .font(.body)
//                                        .fontWeight(.semibold)
                                        .padding()
                                    }
                                    .background(.gray.opacity(0.15))
                                    .cornerRadius(10.0)
                                    
                                    
                                    Button {
                                        Task {
                                            showLoading(.loading)
                                            try? await Task.sleep(nanoseconds: 2_000_000_000)
                                            showLoading(.success)
                                        }
                                    } label: {
                                        HStack(alignment: .top) {
                                            Image(systemName: "star.fill")
                                                .font(.headline)
                                                .foregroundColor(.yellow)
                                            VStack(alignment: .leading) {
                                                Text("சேமித்தவை ")
                                                    .lineLimit(1)
                                                    .foregroundStyle(.black)
                                                Text("(Favourites)")
                                                    .font(.footnote)
                                                    .foregroundStyle(.gray)
                                            }
                                        }
                                        .font(.body)
//                                        .fontWeight(.semibold)
                                        //                                    .foregroundColor(.black)
                                        .padding()
                                    }
                                    .background(.gray.opacity(0.15))
                                    .cornerRadius(10.0)
                                }
                            }
                            .padding(.horizontal)
                                
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
                                                 imageName: "Murugan", //"Thiruvalluvar3",
//                                                 iconName: "book",
                                                 footnote: "1330 குறள்கள்",
                                                 color: Color.blue)
                                }
                                NavigationLink(value: "Athichudi") {
                                    BookTileView(bookTitle: "ஆத்தி சூடி",
                                                 imageName: "Avvaiyar3",
//                                                 iconName: "character.book.closed",
                                                 footnote: "109 வாக்கியங்கள்",
                                                 color: Color.teal)
                                }
                            }
                            HStack(spacing: 16) {
                                NavigationLink(value: "Naaladiyar") {
                                    BookTileView(bookTitle: "நாலடியார்",
                                                 imageName: "Jainmonk",
                                                 footnote: "400 பாடல்கள்",
                                                 color: Color.indigo)
                                }
                                NavigationLink(value: "இனியவை நாற்பது") {
                                    BookTileView(bookTitle: "இனியவை நாற்பது",
//                                                 iconName: "text.book.closed",
                                                 imageName: "Balaji",
                                                 footnote: "40 பாடல்கள்",
                                                 color: Color.purple.opacity(0.7))
                                }
                            }
                            HStack(spacing: 16) {
                                NavigationLink(value: "ஆசாரக் கோவை") {
                                    BookTileView(bookTitle: "ஆசாரக் கோவை",
//                                                 iconName: "book",
                                                 imageName: "Ramar",
                                                 footnote: "100 பாடல்கள்",
                                                 color: Color.red.opacity(0.6))
                                }
                                NavigationLink(value: "நான்மணிக்கடிகை") {
                                    BookTileView(bookTitle: "நான்மணிக் கடிகை",
//                                                 iconName: "text.book.closed",
                                                 imageName: "Meenakshi",
                                                 footnote: "101 பாடல்கள்",
                                                 color: Color.orange.opacity(0.7))
                                }
                                
                            }
                            HStack(spacing: 16) {
                                NavigationLink(value: "இன்னா நாற்பது") {
                                    BookTileView(bookTitle: "இன்னா நாற்பது",
//                                                 iconName: "book",
                                                 imageName: "Karuppusamy",
                                                 footnote: "40 பாடல்கள்",
                                                 color: Color.brown)
//                                                 color: Color.pink.opacity(0.6))
                                }
                                NavigationLink(value: "திரிகடுகம்") {
                                    BookTileView(bookTitle: "திரிகடுகம்",
//                                                 iconName: "text.book.closed",
                                                 imageName: "Adiyogi",
                                                 footnote: "102 பாடல்கள்",
                                                 color: Color.gray)
                                }
                            }
                            HStack(spacing: 16) {
                                NavigationLink(value: "முதுமொழிக் காஞ்சி") {
                                    BookTileView(bookTitle: "முதுமொழிக் காஞ்சி",
                                                 imageName: "Murugan",
                                                 footnote: "100 பழமொழிகள்",
                                                 color: Color.cyan)
                                }
                                NavigationLink(value: "பழமொழி நானூறு") {
                                    BookTileView(bookTitle: "பழமொழி நானூறு",
//                                                 iconName: "text.book.closed",
                                                 imageName: "Balaji",
                                                 footnote: "400 பழமொழிகள்",
                                                 color: Color.green.opacity(0.7))
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
                    BookHomeView(colorTheme: .blue, bookName: "திருக்குறள்")
                } else if value == "Athichudi" {
                    BookHomeView(colorTheme: .teal, bookName: "ஆத்திச்சூடி")
                } else if value == "Naaladiyar" {
//                    NaaladiyarHomeView()
                    BookHomeView(colorTheme: .indigo, bookName: "நாலடியார்")
                } else if value == "இனியவை நாற்பது" {
                    BookHomeView(colorTheme: .purple.opacity(0.7), bookName: "இனியவை நாற்பது")
                } else if value == "ஆசாரக் கோவை" {
                    BookHomeView(colorTheme: .red.opacity(0.6), bookName: "ஆசாரக் கோவை")
                } else if value == "நான்மணிக்கடிகை" {
                    BookHomeView(colorTheme: .orange.opacity(0.7), bookName: "நான்மணிக்கடிகை")
                } else if value == "இன்னா நாற்பது" {
                    BookHomeView(colorTheme: .brown, bookName: "இன்னா நாற்பது")
                } else if value == "திரிகடுகம்" {
                    BookHomeView(colorTheme: .gray, bookName: "திரிகடுகம்")
                } else if value == "முதுமொழிக் காஞ்சி" {
                    BookHomeView(colorTheme: .cyan, bookName: "முதுமொழிக் காஞ்சி")
                } else if value == "பழமொழி நானூறு" {
                    BookHomeView(colorTheme: Color.green.opacity(0.7), bookName: "பழமொழி நானூறு")
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "books.vertical")
                            .font(.title3)
                            .foregroundStyle(.black)
                        
                        Text("Tamil Lit")
                            .font(.title2)
                        
                        Spacer()
                        
                        // Search Bar
//                        HStack {
//                            TextField("பாடல் தேடுக...", text: .constant(""))
//                                .padding(.leading, 10)
//                        }
//                        .padding(10)
//                        .background(Color(.systemGray6))
//                        .cornerRadius(10)
                    }
                    .padding(0)
                }
                
                ToolbarItem {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.black)
                        
                        Text("தேடுக").foregroundStyle(.gray)
                    }.padding(.horizontal)
                }
                
                ToolbarItem {
                    Image(systemName: "gearshape")
                        .foregroundStyle(.black)
                }
            } // toolbar
        } //NavigationStack
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
                        .multilineTextAlignment(.leading)
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
                            .frame(height: 90)
                            .saturation(0.0)
                            .brightness(0.02)
                            .opacity(0.6)
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


//#Preview {
//    HomeView()
//}
