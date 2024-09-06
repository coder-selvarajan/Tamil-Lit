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
    
    private var cancellables = Set<AnyCancellable>()
    private var userSettings: UserSettings
    private var dailyPoemVM = DailyPoemViewModel()
    
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
                    self.schedule64DailyNotifications()
                }
            }
        }
    }
    
    func manageNotifications() {
        if !userSettings.notificationsEnabled {
            return
        }
        
        var futurePoemsCount = dailyPoemVM.getFuturePoemsCount()
//        print("futurePoemsCount: \(futurePoemsCount)")
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            let remainingCount = requests.count
//            print("Pending noti requests: ", remainingCount)
            
            let futureNotifications = min(futurePoemsCount, remainingCount)
            if futureNotifications < 50 {
                let notificationsToAdd = 64 - futureNotifications
                self.scheduleNotifications(upTo: notificationsToAdd)
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
    
    func schedule64DailyNotifications() {
        for day in 0..<64 {
            if let notificationDate = Calendar.current.date(byAdding: .day, value: day, to: Date()) {
                self.scheduleDailyNotification(for: notificationDate)
            }
        }
        
        print("All 64 Daily notifications have been scheduled.")
    }
    
    func scheduleNotifications(upTo count: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        var startDate = Date()
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            if let latestNotification = requests.sorted(by: { $0.identifier > $1.identifier }).first {
                if let latestDate = formatter.date(from: latestNotification.identifier.components(separatedBy: "-").last ?? "") {
                    startDate = Calendar.current.date(byAdding: .day, value: 1, to: latestDate) ?? Date()
                }
            }
            
            for day in 0..<count {
                if let notificationDate = Calendar.current.date(byAdding: .day, value: day, to: startDate) {
                    self.scheduleDailyNotification(for: notificationDate)
                }
            }
        }
    }

    func scheduleDailyNotification(for notificationDate: Date) {
        let content = UNMutableNotificationContent()
        let randomPoem = getDailyPoem(for: notificationDate)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd" // Format date as YYYYMMDD
        
        content.title = randomPoem.1
        content.body = randomPoem.2
        content.sound = .default
        
        //Daily notification
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 0
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: notificationDate)
        dateComponents.year = components.year
        dateComponents.month = components.month
        dateComponents.day = components.day
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let identifier = "dailyPoemNotification-\(formatter.string(from: notificationDate))"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // Schedule the notification
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print("Error scheduling notification: \(String(describing: error?.localizedDescription))")
            } else {
//                print("\(identifier) with - \(content.body.prefix(15))")
            }
        }
    }
    
    func cancelDailyNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func getDailyPoem(for date: Date) -> (String, String, String, String) { // returning id, book title, poem
        var result : (String, String, String, String) = ("Book", "Number", "Poem", "Date")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy" // Set the date format
        let formattedDate = dateFormatter.string(from: date)
        
        if let randomPoem = dailyPoemVM.getthePoemOftheDay(for: date) {
            result.0 = randomPoem.id?.uuidString ?? ""
            result.1 = "\(randomPoem.bookname ?? "") - \(randomPoem.book?.poemType ?? "") \(randomPoem.number)"
            result.2 = randomPoem.poem ?? ""
            result.3 = formattedDate
        }
        
        return result
    }
}
