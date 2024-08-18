//
//  HomeView2.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/05/24.
//

import SwiftUI
import TelemetryDeck

struct HomeView: View {
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var notificationHandler: NotificationHandler
    
    @EnvironmentObject var bookManager: BookManager
    @EnvironmentObject var themeManager: ThemeManager
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    @StateObject var vm = DailyPoemViewModel()
    @StateObject var vmHome = HomeViewModel()
    
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
                        
                        // Book and Category display
                        HStack(alignment: .top) {
                            Text("\(vm.poemOftheDay?.bookname ?? "")\(vm.categoryDisplay)")
                                .font(.subheadline.bold())
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
                            NavigationLink(destination: RandomPoemView()) {
                                VStack(alignment: .center, spacing: size10) {
                                    HStack(spacing: size10) {
                                        Circle()
                                            .fill(Color.yellow.opacity(userSettings.darkMode ? 0.75 : 0.5))
                                            .background(Circle().fill(Color.white)) // to support the look in dark mode
                                            .frame(width: size10, height: size10)
                                        Circle()
                                            .fill(Color.orange.opacity(userSettings.darkMode ? 0.75 : 0.5))
                                            .background(Circle().fill(Color.white)) // to support the look in dark mode
                                            .frame(width: size10, height: size10)
                                        Circle()
                                            .fill(Color.red.opacity(userSettings.darkMode ? 0.75 : 0.5))
                                            .background(Circle().fill(Color.white)) // to support the look in dark mode
                                            .frame(width: size10, height: size10)
                                        
                                        /*
                                        if themeManager.selectedTheme != .primary {
                                            Circle()
                                                .fill(Color.blue.opacity(userSettings.darkMode ? 0.75 : 0.5))
                                                .background(Circle().fill(Color.white)) // to support the look in dark mode
                                                .frame(width: size10, height: size10)
                                            Circle()
                                                .fill(Color.cyan.opacity(userSettings.darkMode ? 0.75 : 0.5))
                                                .background(Circle().fill(Color.white)) // to support the look in dark mode
                                                .frame(width: size10, height: size10)
                                            Circle()
                                                .fill(Color.purple.opacity(userSettings.darkMode ? 0.75 : 0.5))
                                                .background(Circle().fill(Color.white)) // to support the look in dark mode
                                                .frame(width: size10, height: size10)
                                        } else {
                                            Circle()
                                                .fill(Color.yellow.opacity(userSettings.darkMode ? 0.75 : 0.5))
                                                .background(Circle().fill(Color.white)) // to support the look in dark mode
                                                .frame(width: size10, height: size10)
                                            Circle()
                                                .fill(Color.orange.opacity(userSettings.darkMode ? 0.75 : 0.5))
                                                .background(Circle().fill(Color.white)) // to support the look in dark mode
                                                .frame(width: size10, height: size10)
                                            Circle()
                                                .fill(Color.red.opacity(userSettings.darkMode ? 0.75 : 0.5))
                                                .background(Circle().fill(Color.white)) // to support the look in dark mode
                                                .frame(width: size10, height: size10)
                                        }
                                         */
                                    }.frame(height: size30)
                                    VStack(alignment: .leading) {
                                        Text("Random Poem")
//                                        Text("ஏதோ ஒரு பாடல்")
                                            .lineLimit(1)
                                            .foregroundStyle(Color("TextColor"))
                                    }
                                }
                                .font(.body.bold())
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.gray.opacity(0.15))
                                .cornerRadius(size10)
                            }
                            
                            NavigationLink(destination: SavedPoemListView()) {
                                VStack(alignment: .center, spacing: size10) {
                                    HStack {
                                        Image(systemName: "bookmark.fill")
                                            .font(.title3)
                                            .foregroundColor(.yellow.opacity(userSettings.darkMode ? 0.9 : 0.7))
                                        
                                        /*
                                        if themeManager.selectedTheme != .primary {
                                            Image(systemName: "bookmark.fill")
                                                .font(.title3)
                                                .foregroundColor(.cyan.opacity(userSettings.darkMode ? 0.9 : 0.6))
                                        } else {
                                            Image(systemName: "bookmark.fill")
                                                .font(.title3)
                                                .foregroundColor(.yellow.opacity(userSettings.darkMode ? 0.9 : 0.6))
                                        }
                                        */
                                    }.frame(height: size30)
                                    
                                    Text("Saved ")
//                                    Text("சேமித்தவை ")
                                        .lineLimit(1)
                                        .foregroundStyle(Color("TextColor"))
                                }
                                .font(.body.bold())
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
                        }
                        
                        ForEach(bookManager.books.chunked(into: 2), id: \.self) { bookPair in
                            HStack(spacing: 16) {
                                ForEach(bookPair.indices, id: \.self) { index in
                                    let bookBinding = $bookManager.books[bookPair[index].order - 1]
                                    let bookItem = bookManager.books[bookPair[index].order - 1]
                                    let isActiveBinding = Binding<Bool>(
                                        get: { navigationManager.activeBook[bookItem.id] ?? false },
                                        set: { navigationManager.activeBook[bookItem.id] = $0 }
                                    )
                                    let bookViewSummary =  vmHome.getBookView(for: bookItem)
                                    
                                    NavigationLink(destination: BookHomeView(book: bookItem)
                                        .environmentObject(navigationManager),
                                                   isActive: isActiveBinding) {
                                        BookTileView(book: bookBinding,
                                                     bookDisplayAsGrid: $bookDisplayAsGrid,
                                                     bookViewSummary: Binding(
                                                        get: { bookViewSummary },
                                                        set: { newValue in
                                                            //
                                                        }))
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    
                    //Recently Viewed
                    LastFiveViewedPoemsView()
                    
                    // Tamil Articles Links
                    VStack(spacing: size15) {
                        HStack {
                            
                            Image(systemName: "square.text.square")
                                .font(.title2)
                                .padding(.trailing, 5)
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
                    
                    
//                    VStack{
//                        Text(" ")
//                    }.frame(height: size10)
                    
                    Spacer()
                }
            }
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            // Fetch the poem of the day
            vm.getPoemOftheDay()
            
            // Open the daily poem popup when the user comes from the daily notification message..
            if notificationHandler.appOpenedFromNotification {
                notificationHandler.appOpenedFromNotification = false
                showPoemPopup = true
            }
            
            // BookViewSummary
            vmHome.getAllBookViewSummry()
            
            //Analytics code
            TelemetryDeck.signal(
                "Page Load",
                parameters: [
                    "app": "Tamil Lit",
                    "event": "page load",
                    "identifier":"home-view",
                    "viewName":"Home View"
                ]
            )
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
                        .saturation(themeManager.selectedTheme == ThemeSelection.primary ?  0.5 : 1.0)
                        .opacity(0.9)
                    
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
                        
                        Text("Search").foregroundStyle(.gray)
                    }.padding(.horizontal)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape")
                        .foregroundStyle(Color("TextColor"))
                }
            }
        } // toolbar
        .customFontScaling()
    }
}

