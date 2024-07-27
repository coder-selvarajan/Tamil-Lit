//
//  AppDelegate.swift
//  Tamil Lit
//
//  Created by Selvarajan on 27/07/24.
//

import SwiftUI
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        NotificationCenter.default.post(name: .appOpenedFromNotification, object: nil)
        completionHandler()
    }
}

extension Notification.Name {
    static let appOpenedFromNotification = Notification.Name("appOpenedFromNotification")
}
