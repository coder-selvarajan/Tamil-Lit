//
//  NotificationHandler.swift
//  Tamil Lit
//
//  Created by Selvarajan on 27/07/24.
//

import SwiftUI
import Combine
import CoreData

class NotificationHandler: ObservableObject {
    @Published var appOpenedFromNotification: Bool = false
    @StateObject var vm = DailyPoemViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    private var userSettings: UserSettings
    
    init(userSettings: UserSettings) {
        self.userSettings = userSettings
        NotificationCenter.default.publisher(for: .appOpenedFromNotification)
            .sink { [weak self] _ in
                self?.appOpenedFromNotification = true
            }
            .store(in: &cancellables)
    }

    func checkFirstLaunch() {
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
        if !isFirstLaunch {
            UserDefaults.standard.setValue(true, forKey: "isFirstLaunch")
            requestNotificationPermission { granted in
                if granted {
                    self.scheduleDailyNotification()
                }
            }
        }
    }
    
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .notDetermined:
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                        DispatchQueue.main.async {
                            if granted {
                                print("Notification permission granted.")
                                self.userSettings.notificationsEnabled = true
                                completion(true)
                            } else {
                                print("Notification permission denied.")
                                self.userSettings.notificationsEnabled = false
                                completion(false)
                            }
                        }
                    }
                case .denied:
                    print("Notification permission previously denied.")
                    self.userSettings.notificationsEnabled = false
                    completion(false)
                case .authorized, .provisional, .ephemeral:
                    print("Notification permission previously granted.")
                    self.userSettings.notificationsEnabled = true
                    completion(true)
                @unknown default:
                    completion(false)
                }
            }
        }
    }

    func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        let randomPoem = getRandomPoem()
        content.title = randomPoem.1
        content.body = randomPoem.2
        content.sound = .default
        
        //Daily notification
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Test notification
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 100, repeats: true) // 300 seconds = 5 minutes
        
        let request = UNNotificationRequest(
            identifier: "dailyPoemNotification", // UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
        
        print("Daily notification scheduled.")
    }
    
    func cancelDailyNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyPoemNotification"])
    }
    
    func getRandomPoem() -> (String, String, String) { // returning id, book title, poem
        var result : (String, String, String) = ("Book", "Number", "Poem")
        
        if let randomPoem = vm.getthePoemOftheDay() {
            result.0 = randomPoem.id?.uuidString ?? ""
            result.1 = "\(randomPoem.bookname ?? "") - \(randomPoem.book?.poemType ?? "") \(randomPoem.number)"
            result.2 = randomPoem.poem ?? ""
        }
        
        return result
    }
}
