//
//  Tamil_LitApp.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

@main
struct Tamil_LitApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var userSettings = UserSettings()
    @StateObject private var notificationHandler = NotificationHandler(userSettings: UserSettings())
    
    @StateObject var navigationManager = NavigationManager()
    @StateObject var themeManager = ThemeManager()
    @StateObject var bookManager = BookManager()
    
    let persistenceController = CoreDataManager.shared
//    @State private var loadingStatus: LoadingStatus  = .idle
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(userSettings)
                .preferredColorScheme(userSettings.darkMode ? .dark : .light)
                .environment(\.managedObjectContext, persistenceController.viewContext)
                .environmentObject(notificationHandler)
                .environmentObject(navigationManager)
                .environmentObject(themeManager)
                .environmentObject(bookManager)
                .environment(\.customFontScaling, userSettings.fontScaling.sizeCategory)
                .onAppear {
                    notificationHandler.checkFirstLaunch()
                }
            
//                .environment(\.showLoading) { loadingStatus in
//                    self.loadingStatus = loadingStatus
//                }
//                .overlay(alignment: .center) {
//                    if loadingStatus == .loading {
//                        LoadingView()
//                    }
//                }
        }
    }
}
