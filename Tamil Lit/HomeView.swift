//
//  HomeView2.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/05/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.showLoading) private var showLoading
    @StateObject var vm = HomeViewModel()
    
    @State var bookDisplayAsGrid: Bool = true
    @State private var showPoemPopup = false
    @State private var currentDate: Date = Date()
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        return formatter.string(from: currentDate)
    }
    
    private var isTodayOrAfter: Bool {
        let now = Date()
        return currentDate >= Calendar.current.startOfDay(for: now)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        // Daily poem
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(alignment: .center) {
                                Text("தினம் ஒரு பாடல்")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Button {
                                    currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
                                    vm.getPoemOftheDay()
                                } label: {
                                    Image(systemName: "arrowtriangle.left.circle")
                                        .font(.title3)
                                        .foregroundColor(.black)
                                }
                                
                                Text(formattedDate)
                                    .font(.subheadline)
                                    .foregroundStyle(.black.opacity(0.85))
//                                    .padding(.horizontal, 5)
                                
                                Button {
                                    currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
                                    vm.getPoemOftheDay()
                                } label: {
                                    Image(systemName: "arrowtriangle.right.circle")
                                        .font(.title3)
                                        .foregroundColor(.black)
                                }
                                .disabled(isTodayOrAfter)
                                .opacity(isTodayOrAfter ? 0.3 : 1.0)
                                
                            }
                            .padding(.bottom, 5)
                            
                            Divider().padding(.vertical, 10)
                            
//                            Spacer()
                            
                            // Book and Category display
                            HStack(alignment: .top) {
                                Text("\(vm.poemOftheDay?.bookname ?? "")\(vm.categoryDisplay)")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 10)
                                
                                Spacer()
                            }
                            
                            // Daily poem display
                            Text(vm.poemOftheDay?.poem ?? "")
                                .lineLimit(3)
                                .onTapGesture {
                                    showPoemPopup = true
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.gray.opacity(0.15))
                        .cornerRadius(8)
                        .padding()
                        
                        // Action Section
                        VStack (alignment: .leading) {
                            HStack(spacing: 15) {
                                NavigationLink(value: "RandomPoemView") {
                                    VStack(alignment: .center, spacing: 10) {
                                        Image(systemName: "wand.and.stars")
                                            .font(.title)
                                            .foregroundColor(.pink)
                                        VStack(alignment: .leading) {
                                            Text("ஏதோ ஒரு பாடல்")
                                                .lineLimit(1)
                                                .foregroundStyle(.black)
                                        }
                                    }
                                    .font(.body)
                                    .padding()
                                    .frame(maxWidth: .infinity)
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
                                    VStack(alignment: .center, spacing: 10) {
                                        Image(systemName: "bookmark.fill")
                                            .font(.title)
                                            .foregroundColor(.yellow)
                                        Text("சேமித்தவை ")
                                            .lineLimit(1)
                                            .foregroundStyle(.black)
                                    }
                                    .font(.body)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                }
                                .background(.gray.opacity(0.15))
                                .cornerRadius(10.0)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                        }
                        
                        // Tiles
                        VStack(spacing: 16) {
                            HStack {
                                
                                Image(systemName: "books.vertical")
                                    .font(.title2)
                                    .padding(.trailing, 5)
                                Text("தமிழ் இலக்கிய நூல்கள்")
                                    .font(.title3)
                                
                                Spacer()
                                
                                Picker("View", selection: $bookDisplayAsGrid) {
                                    Image(systemName: "list.dash").tag(false)
                                    Image(systemName: "square.grid.2x2").tag(true)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .frame(width: 60)
                            }
                            
                            ForEach(_books.chunked(into: 2), id: \.self) { bookPair in
                                HStack(spacing: 16) {
                                    ForEach(bookPair) { book in
                                        NavigationLink(value: book.title) {
                                            BookTileView(bookTitle: book.title,
                                                         imageName: book.image,
                                                         footnote: book.subtitle,
                                                         color: book.color,
                                                         bookDisplayAsGrid: $bookDisplayAsGrid)
                                        }
                                    }
                                }
                            }
                            
//                            HStack(spacing: 16) {
//                                NavigationLink(value: "திருக்குறள்") {
//                                    BookTileView(bookTitle: "திருக்குறள்",
//                                                 imageName: "Murugan", //"Thiruvalluvar3",
//                                                 footnote: "1330 குறள்கள்",
//                                                 color: Color.blue,
//                                                 bookDisplayAsGrid: $bookDisplayAsGrid)
//                                }
//                                NavigationLink(value: "ஆத்திசூடி") {
//                                    BookTileView(bookTitle: "ஆத்திசூடி",
//                                                 imageName: "Avvaiyar3",
//                                                 footnote: "109 வாக்கியங்கள்",
//                                                 color: Color.teal,
//                                                 bookDisplayAsGrid: $bookDisplayAsGrid)
//                                }
//                            }
//                            HStack(spacing: 16) {
//                                NavigationLink(value: "நாலடியார்") {
//                                    BookTileView(bookTitle: "நாலடியார்",
//                                                 imageName: "Jainmonk",
//                                                 footnote: "400 பாடல்கள்",
//                                                 color: Color.indigo,
//                                                 bookDisplayAsGrid: $bookDisplayAsGrid)
//                                }
//                                NavigationLink(value: "இனியவை நாற்பது") {
//                                    BookTileView(bookTitle: "இனியவை நாற்பது",
//                                                 imageName: "Balaji",
//                                                 footnote: "40 பாடல்கள்",
//                                                 color: Color.purple.opacity(0.7),
//                                                 bookDisplayAsGrid: $bookDisplayAsGrid)
//                                }
//                            }
//                            HStack(spacing: 16) {
//                                NavigationLink(value: "ஆசாரக் கோவை") {
//                                    BookTileView(bookTitle: "ஆசாரக் கோவை",
//                                                 imageName: "Ramar",
//                                                 footnote: "100 பாடல்கள்",
//                                                 color: Color.red.opacity(0.6),
//                                                 bookDisplayAsGrid: $bookDisplayAsGrid)
//                                }
//                                NavigationLink(value: "நான்மணிக்கடிகை") {
//                                    BookTileView(bookTitle: "நான்மணிக் கடிகை",
//                                                 imageName: "Meenakshi",
//                                                 footnote: "101 பாடல்கள்",
//                                                 color: Color.orange.opacity(0.7),
//                                                 bookDisplayAsGrid: $bookDisplayAsGrid)
//                                }
//                                
//                            }
//                            HStack(spacing: 16) {
//                                NavigationLink(value: "இன்னா நாற்பது") {
//                                    BookTileView(bookTitle: "இன்னா நாற்பது",
//                                                 imageName: "Karuppusamy",
//                                                 footnote: "40 பாடல்கள்",
//                                                 color: Color.brown,
//                                                 bookDisplayAsGrid: $bookDisplayAsGrid)
//                                }
//                                NavigationLink(value: "திரிகடுகம்") {
//                                    BookTileView(bookTitle: "திரிகடுகம்",
//                                                 imageName: "Adiyogi",
//                                                 footnote: "102 பாடல்கள்",
//                                                 color: Color.gray,
//                                                 bookDisplayAsGrid: $bookDisplayAsGrid)
//                                }
//                            }
//                            HStack(spacing: 16) {
//                                NavigationLink(value: "முதுமொழிக் காஞ்சி") {
//                                    BookTileView(bookTitle: "முதுமொழிக் காஞ்சி",
//                                                 imageName: "Murugan",
//                                                 footnote: "100 பழமொழிகள்",
//                                                 color: Color.cyan,
//                                                 bookDisplayAsGrid: $bookDisplayAsGrid)
//                                }
//                                NavigationLink(value: "பழமொழி நானூறு") {
//                                    BookTileView(bookTitle: "பழமொழி நானூறு",
//                                                 imageName: "Balaji",
//                                                 footnote: "400 பழமொழிகள்",
//                                                 color: Color.green.opacity(0.7),
//                                                 bookDisplayAsGrid: $bookDisplayAsGrid)
//                                }
//                                
//                            }
                        }
                        .padding()
                        
                        VStack{
                            Text(" ")
                        }.frame(height: 40.0)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self) { value in
                if let book = _books.first(where: { $0.title == value }) {
                    BookHomeView(colorTheme: book.color, bookName: book.title)
                } else if value == "RandomPoemView" {
                    RandomPoemView()
                }
            }
//            .navigationDestination(for: String.self) { value in
//                if value == "திருக்குறள்" {
//                    BookHomeView(colorTheme: .blue, bookName: "திருக்குறள்")
//                } else if value == "ஆத்திசூடி" {
//                    BookHomeView(colorTheme: .teal, bookName: "ஆத்திசூடி")
//                } else if value == "நாலடியார்" {
//                    BookHomeView(colorTheme: .indigo, bookName: "நாலடியார்")
//                } else if value == "இனியவை நாற்பது" {
//                    BookHomeView(colorTheme: .purple.opacity(0.7), bookName: "இனியவை நாற்பது")
//                } else if value == "ஆசாரக் கோவை" {
//                    BookHomeView(colorTheme: .red.opacity(0.6), bookName: "ஆசாரக் கோவை")
//                } else if value == "நான்மணிக்கடிகை" {
//                    BookHomeView(colorTheme: .orange.opacity(0.7), bookName: "நான்மணிக்கடிகை")
//                } else if value == "இன்னா நாற்பது" {
//                    BookHomeView(colorTheme: .brown, bookName: "இன்னா நாற்பது")
//                } else if value == "திரிகடுகம்" {
//                    BookHomeView(colorTheme: .gray, bookName: "திரிகடுகம்")
//                } else if value == "முதுமொழிக் காஞ்சி" {
//                    BookHomeView(colorTheme: .cyan, bookName: "முதுமொழிக் காஞ்சி")
//                } else if value == "பழமொழி நானூறு" {
//                    BookHomeView(colorTheme: Color.green.opacity(0.7), bookName: "பழமொழி நானூறு")
//                }
//                
//                // Random Poem View
//                if value == "RandomPoemView" {
//                    RandomPoemView()
//                }
//            }
            .onAppear() {
                // Fetch the poem of the day
                vm.getPoemOftheDay()
            }
            .sheet(isPresented: $showPoemPopup) {
                SimplePoemDetailView(selectedPoem: $vm.poemOftheDay, popupMode: true)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image("114")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                        
//                        Image(systemName: "books.vertical")
//                            .font(.title3)
//                            .foregroundStyle(.black)
                        
                        Text("Tamil Lit")
                            .font(.custom("Quicksand", size: 22))
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    .padding(0)
                }
                
                ToolbarItem {
                    NavigationLink(destination: SearchView()) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.black)
                            
                            Text("தேடுக").foregroundStyle(.gray)
                        }.padding(.horizontal)
                    }
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
    var footnote: String
    var color: Color = Color.clear
    
    @Binding var bookDisplayAsGrid: Bool
    
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
            
            if bookDisplayAsGrid {
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
        }
        .frame(height: bookDisplayAsGrid ? 150 : 90)
    }
}

//struct TabBarButton: View {
//    var iconName: String
//    var label: String
//    
//    var body: some View {
//        VStack(spacing: 5) {
//            Image(systemName: iconName)
//            Text(label)
//                .font(.footnote)
//        }
//    }
//}

//#Preview {
//    HomeView()
//}
