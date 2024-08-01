//
//  HomeView2.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/05/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var notificationHandler: NotificationHandler
    @Environment(\.showLoading) private var showLoading
    
    @StateObject var vm = DailyPoemViewModel()
    
    @State var bookDisplayAsGrid: Bool = true
    @State private var showPoemPopup = false
    @State private var currentDate: Date = Date()
    
    let paddingSize: CGFloat = UIScreen.main.bounds.size.width * 0.055 // aprox 20 for 375 screen size..
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        return formatter.string(from: currentDate)
    }
    
    private var isTodayOrAfter: Bool {
        let now = Date()
        return currentDate >= Calendar.current.startOfDay(for: now)
    }

    private var isBeforeFirstDailyPoem: Bool {
        if let firstDailyPoemDate = vm.firstDailyPoemDate {
            if let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: firstDailyPoemDate)) {
                return currentDate <= nextDay
            }
        }

        return true
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
                                    vm.getDailyPoemFor(currentDate)
                                } label: {
                                    Image(systemName: "arrowtriangle.left.circle")
                                        .font(.title3)
                                        .foregroundColor(Color("TextColor"))
                                }
                                .disabled(isBeforeFirstDailyPoem)
                                .opacity(isBeforeFirstDailyPoem ? 0.3 : 1.0)
                                
                                
                                Text(formattedDate)
                                    .font(.subheadline)
                                    .foregroundStyle(Color("TextColor").opacity(0.85))
//                                    .padding(.horizontal, 5)
                                
                                Button {
                                    currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
                                    vm.getDailyPoemFor(currentDate)
                                } label: {
                                    Image(systemName: "arrowtriangle.right.circle")
                                        .font(.title3)
                                        .foregroundColor(Color("TextColor"))
                                }
                                .disabled(isTodayOrAfter)
                                .opacity(isTodayOrAfter ? 0.3 : 1.0)
                                
                            }
                            .padding(.bottom, 5)
                            
                            Divider().padding(.vertical, size10)
                            
//                            Spacer()
                            
                            // Book and Category display
                            HStack(alignment: .top) {
                                Text("\(vm.poemOftheDay?.bookname ?? "")\(vm.categoryDisplay)")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, size10)
                                
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
                        .cornerRadius(size10)
                        .padding()
                        
                        // Action Section
                        VStack (alignment: .leading) {
                            HStack(spacing: size15) {
                                NavigationLink(value: "RandomPoemView") {
                                    VStack(alignment: .center, spacing: size10) {
                                        HStack(spacing: size10) {
                                            Circle()
                                                .fill(Color.white)
                                                .fill(Color.blue.opacity(userSettings.darkMode ? 0.75 : 0.6))
                                                .frame(width: size10, height: size10)
                                            Circle()
                                                .fill(Color.white)
                                                .fill(Color.cyan.opacity(userSettings.darkMode ? 0.75 : 0.6))
                                                .frame(width: size10, height: size10)
                                            Circle()
                                                .fill(Color.white)
                                                .fill(Color.purple.opacity(userSettings.darkMode ? 0.7 : 0.55))
                                                .frame(width: size10, height: size10)
                                            
                                        }.frame(height: size30)
                                        VStack(alignment: .leading) {
                                            Text("ஏதோ ஒரு பாடல்")
                                                .lineLimit(1)
                                                .foregroundStyle(Color("TextColor"))
                                        }
                                    }
                                    .font(.subheadline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(.gray.opacity(0.15))
                                    .cornerRadius(size10)
                                }
                                
                                NavigationLink(value: "FavouritePoemView") {
                                    VStack(alignment: .center, spacing: size10) {
                                        HStack {
//                                            Image(systemName: "bookmark.fill")
//                                                .font(.title3)
//                                                .foregroundColor(.blue.opacity(0.5))
                                            Image(systemName: "bookmark.fill")
                                                .font(.title3)
                                                .foregroundColor(.cyan.opacity(userSettings.darkMode ? 0.9 : 0.7))
                                        }.frame(height: size30)
                                        
                                        Text("சேமித்தவை ")
                                            .lineLimit(1)
                                            .foregroundStyle(Color("TextColor"))
                                    }
                                    .font(.subheadline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    //                                }
                                    .background(.gray.opacity(0.15))
                                    .cornerRadius(size10)
                                }
                                
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
                                
//                                Picker("View", selection: $bookDisplayAsGrid) {
//                                    Image(systemName: "list.dash").tag(false)
//                                    Image(systemName: "square.grid.2x2").tag(true)
//                                }
//                                .pickerStyle(SegmentedPickerStyle())
//                                .frame(width: 60)
                            }
                            
                            ForEach(_books.chunked(into: 2), id: \.self) { bookPair in
                                HStack(spacing: 16) {
                                    ForEach(bookPair) { book in
                                        NavigationLink(value: book.title) {
                                            BookTileView(bookTitle: book.title,
                                                         imageName: book.image,
                                                         footnote: book.subtitle,
                                                         color: book.color,
                                                         bannerColor: book.bannerColor,
                                                         bookDisplayAsGrid: $bookDisplayAsGrid)
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                        
                        // Tamil Articles Links
                        VStack(spacing: size15) {
                            HStack {
                                
                                Image(systemName: "square.text.square")
                                    .font(.title2)
                                    .padding(.trailing, 5)
//                                Text("வரலாற்று தகவல்கள்")
//                                    .font(.title3)
                                Text("வரலாற்று தகவல்கள்")
                                    .font(.title3)
                                
                                Spacer()
                            }
                            
                            VStack {
                                VStack {
                                    NavigationLink(destination: ArticleView(fileName: "TamilLiterature")) {
                                        HStack {
                                            Text("தமிழ் இலக்கிய வரலாறு")
                                                .foregroundColor(Color("TextColor"))
                                            
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.vertical, 5)
                                    }
                                    Divider()
                                }
                                
                                VStack {
                                    NavigationLink(destination: ArticleView(fileName: "SangaIlakkiyam")) {
                                        HStack {
                                            Text("சங்க இலக்கியம்")
                                                .foregroundColor(Color("TextColor"))
                                            
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.vertical, 5)
                                    }
                                    
                                    Divider()
                                    
                                }
                                
                                VStack {
                                    NavigationLink(destination: ArticleView(fileName: "SangaIlakkiyaNoolkal")) {
                                        HStack {
                                            Text("சங்க இலக்கிய நூல்கள்")
                                                .foregroundColor(Color("TextColor"))
                                            
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.vertical, 5)
                                    }
                                    Divider()
                                }
                                
                                VStack {
                                    NavigationLink(destination: ArticleView(fileName: "Idaikaala-Ilakkiyam")) {
                                        HStack {
                                            Text("இடைக்கால இலக்கியம்")
                                                .foregroundColor(Color("TextColor"))
                                            
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.vertical, 5)
                                    }
                                    Divider()
                                }
                                
                                VStack {
                                    NavigationLink(destination: ArticleView(fileName: "Naveena-Yugam")) {
                                        HStack {
                                            Text("நவீன யுகம்")
                                                .foregroundColor(Color("TextColor"))
                                            
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.vertical, 5)
                                    }
//                                    Divider()
                                }
                                
                            }
                            .padding()
                            .background(.gray.opacity(0.1))
                            .cornerRadius(size10)
                            
                        }
                        .padding()
                        
                        
                        VStack{
                            Text(" ")
                        }.frame(height: size40)
                        
                        Spacer()
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self) { value in
                if let book = _books.first(where: { $0.title == value }) {
                    BookHomeView(colorTheme: book.color, bookName: book.title)
                } else if value == "RandomPoemView" {
                    RandomPoemView()
                } else if value == "FavouritePoemView" {
                    FavouritePoemListView()
                } else if value == "Article" {
                    ArticleView()
                }
            }
            .onAppear() {
                // Fetch the poem of the day
                vm.getPoemOftheDay()
                
                // Open the daily poem popup when the user comes from the daily notification message..
                if notificationHandler.appOpenedFromNotification {
                    notificationHandler.appOpenedFromNotification = false
                    showPoemPopup = true
                }
            }
            .onChange(of: notificationHandler.appOpenedFromNotification, perform: { newValue in
                // this code is added since the app is open and the onAppear event would n't trigger..
                if newValue {
                    print("App opened from notification")
                    showPoemPopup = true
                }
            })
            .sheet(isPresented: $showPoemPopup) {
                if vm.poemOftheDay != nil {
                    SimplePoemDetailView(selectedPoem: Binding($vm.poemOftheDay)!, popupMode: true)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image("114")
                            .resizable()
                            .scaledToFit()
                            .frame(width: size40)
                            .cornerRadius(size10)
                        
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
                                .foregroundStyle(Color("TextColor"))
                            
                            Text("தேடுக").foregroundStyle(.gray)
                        }.padding(.horizontal)
                    }
                }
                
                ToolbarItem {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                            .foregroundStyle(Color("TextColor"))
                    }
                }
            } // toolbar
        } //NavigationStack
    }
}

struct BookTileView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var colors = [Color.blue, Color.green, Color.red, Color.cyan, Color.indigo, Color.orange, Color.purple, Color.brown, Color.teal, Color.pink, Color.gray, Color.yellow]
    var bookTitle: String
    var imageName: String?
    var footnote: String
    var color: Color = Color.clear
    var bannerColor: String
    
    @Binding var bookDisplayAsGrid: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: size10)
                .fill(userSettings.darkMode ? Color.white : Color.clear)
                .fill(userSettings.darkMode ? color.opacity(0.45) : color.opacity(0.25))
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: size10) {
                    Text(bookTitle)
                        .font(.headline)
                        .foregroundStyle(.black)
//                        .foregroundStyle(Color("TextColor"))
                        .fontWeight(Font.Weight.semibold)
                        .multilineTextAlignment(.leading)
                        //.lineLimit(1)
                    Text(footnote)
                        .font(.footnote)
                        .foregroundStyle(.black.opacity(0.7))
//                        .foregroundColor(Color("TextColor").opacity(0.7))
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
                                .frame(height: 80)
                                .saturation(0.1)
//                                .brightness(0.0)
//                                .contrast(0.5)
                                .opacity(0.8)
                        }
                        else {
                            Image("book-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: size50)
                                .saturation(0.0)
                                .opacity(0.6)
                                .padding()
                        }
                    }.padding(0)
                }.padding(0)
            }
        }
        .frame(height: 150)
    }
}

//#Preview {
//    HomeView()
//}
