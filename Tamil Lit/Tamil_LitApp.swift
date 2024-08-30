//
//  Tamil_LitApp.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI
import TelemetryDeck

@main
struct Tamil_LitApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var userSettings = UserSettings()
    @StateObject private var notificationHandler = NotificationHandler(userSettings: UserSettings())
    
    @StateObject var navigationManager = NavigationManager()
    @StateObject var themeManager = ThemeManager()
    @StateObject var bookManager = BookManager()
    
    @StateObject var speechSynthesizer = SpeechSynthesizer()
    
    let persistenceController = CoreDataManager.shared
//    @State private var loadingStatus: LoadingStatus  = .idle
    
    init() {
        let config = TelemetryDeck.Config(appID: "1C8C778D-C7DA-49BD-AD34-D6396724E6D2")
        TelemetryDeck.initialize(config: config)
        
        TelemetryDeck.signal(
            "App Launched",
            parameters: [
                "app": "Tamil Lit",
                "event": "app_load"
            ]
        )
    }
    
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
                .environmentObject(speechSynthesizer)
                .environment(\.customFontScaling, userSettings.fontScaling.sizeCategory)
                .onAppear {
                    notificationHandler.checkFirstLaunch()
                    
                    //Analytics instrumentation
                    instrumentWithSwiftUIAnalytics()
                }
        }
    }
}

func instrumentWithSwiftUIAnalytics(){
    DispatchQueue.main.async {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootView = windowScene.windows.first?.rootViewController?.view {
            rootView.accessibilityActivate()
            print("Activating accessibility info")
        } else {
            print("No accessible windows found.")
        }
    }
    
    // SwiftUI Analytics
    let uiAppClass = UIApplication.self
    let currentSendEvent = class_getInstanceMethod(uiAppClass, #selector(uiAppClass.sendEvent))
    let newSendEvent = class_getInstanceMethod(uiAppClass, #selector(uiAppClass.newSendEvent))
    method_exchangeImplementations(currentSendEvent!, newSendEvent!)
    print("Swizzlling called")
}
