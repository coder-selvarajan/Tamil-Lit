//
//  AppDelegate.swift
//  Tamil Lit
//
//  Created by Selvarajan on 27/07/24.
//

import SwiftUI
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
        // Check the value of darkMode from AppStorage (UserDefaults)
        let darkMode = UserDefaults.standard.bool(forKey: "darkMode")
        
        // Apply the theme based on darkMode setting
        applyTheme(darkMode: darkMode)
        
        return true
    }
    
    func applyTheme(darkMode: Bool) {
        // Set the interface style based on the darkMode value
        if darkMode {
            window?.overrideUserInterfaceStyle = .dark
        } else {
            window?.overrideUserInterfaceStyle = .light
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        NotificationCenter.default.post(name: .appOpenedFromNotification, object: nil)
        completionHandler()
    }
}

extension Notification.Name {
    static let appOpenedFromNotification = Notification.Name("appOpenedFromNotification")
}
