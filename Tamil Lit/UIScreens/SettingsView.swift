//
//  SettingsView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 25/07/24.
//

import Foundation
import SwiftUI
import StoreKit
import AVFoundation


struct SettingsView: View {
    @AppStorage("speechRate") var speechRate: Double = Double(AVSpeechUtteranceDefaultSpeechRate)
        
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var bookManager: BookManager
    
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var notificationHandler: NotificationHandler
    
    @State private var activeAlert: ActiveAlert?
    
    let speechRates: [Double] = [0.3, 0.4, 0.5, 0.6]
    let speechRateLabels = ["Slow", "Normal", "Fast", "Very Fast"]
    
    enum ActiveAlert: Identifiable {
        case settings, feedback
        
        var id: Int {
            hashValue
        }
    }
    
    func speechSpeedDescription(for rate: Double) -> String {
        switch rate {
        case 0.1..<0.2:
            return "Very Slow"
        case 0.2..<0.3:
            return "Slow"
        case 0.3..<0.5:
            return "Normal"
        case 0.5..<0.6:
            return "Fast"
        default:
            return "Very Fast"
        }
    }
    
    var body: some View {
        VStack {
            List {
                SwiftUI.Section {
                    Toggle(isOn: $userSettings.notificationsEnabled) {
                        VStack(alignment: .leading) {
                            Text("தினம் ஒரு பாடல் அறிவிப்பு")
                                .font(.headline)
                            Text("Enable/Disable Push Notification")
                                .font(.footnote)
                        }
                    }
                    .padding(.vertical, 2)
                    .onChange(of: userSettings.notificationsEnabled) { value in
                        if value {
                            // checking if the user allow the notification from this app.
                            notificationHandler.requestNotificationPermission { granted in
                                if granted {
                                    notificationHandler.schedule64DailyNotifications()
                                } else {
                                    userSettings.notificationsEnabled = false
                                    activeAlert = .settings
                                }
                            }
                        } else {
                            notificationHandler.cancelDailyNotification()
                        }
                    }
                }
                
                SwiftUI.Section(header: Text("Choose your theme").font(.subheadline.bold())) {
                    VStack(spacing: size15) {
                        Button(action: {
                            performMediumHapticFeedback()
                            userSettings.darkMode = false
                            themeManager.setTheme(.colorful)
                            bookManager.updateBooks(with: themeManager.currentTheme)
                        }) {
                            HStack {
                                Text("Colorful")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Spacer()
                                
                                Circle()
                                    .fill(Color.blue.opacity(userSettings.darkMode ? 0.75 : 0.5))
                                    .background(Circle().fill(Color.white)) // to support the look in dark mode
                                    .frame(width: size10, height: size10)
                                Circle()
                                    .fill(Color.purple.opacity(userSettings.darkMode ? 0.75 : 0.5))
                                    .background(Circle().fill(Color.white)) // to support the look in dark mode
                                    .frame(width: size10, height: size10)
                            }
                        }
                        .buttonStyle(RoundedBackgroundButtonStyle(isSelected: themeManager.selectedTheme == .colorful))
                        
                        Button(action: {
                            performMediumHapticFeedback()
                            userSettings.darkMode = false
                            themeManager.setTheme(.light)
                            bookManager.updateBooks(with: themeManager.currentTheme)
                        }) {
                            HStack {
                                Text("Monochrome")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Spacer()
                                
                                Circle()
                                    .fill(Color.white)
                                    .background(Circle().fill(Color.white)) // to support the look in dark mode
                                    .frame(width: size10, height: size10)
                                Circle()
                                    .fill(Color.gray.opacity(0.75))
                                    .background(Circle().fill(Color.white)) // to support the look in dark mode
                                    .frame(width: size10, height: size10)
                            }
                        }
                        .buttonStyle(RoundedBackgroundButtonStyle(isSelected: themeManager.selectedTheme == .light))
                        
                        Button(action: {
                            performMediumHapticFeedback()
                            userSettings.darkMode = true
                            themeManager.setTheme(.dark)
                            bookManager.updateBooks(with: themeManager.currentTheme)
                        }) {
                            HStack {
                                Text("Dark Mode")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Spacer()
                                
                                Circle()
                                    .fill(Color.black.opacity(userSettings.darkMode ? 0.75 : 0.5))
                                    .background(Circle().fill(Color.white)) // to support the look in dark mode
                                    .frame(width: size10, height: size10)
                                Circle()
                                    .fill(Color.black)
                                    .background(Circle().fill(Color.white)) // to support the look in dark mode
                                    .frame(width: size10, height: size10)
                            }
                        }
                        .buttonStyle(RoundedBackgroundButtonStyle(isSelected: themeManager.selectedTheme == .dark))
                    }
                    .padding(.vertical)
                }
                
                SwiftUI.Section(header: Text("Adjust Font Scaling").font(.subheadline.bold())) {
                    VStack(spacing: size15) {
                        HStack(spacing: size15) {
                            Button(action: {
                                performMediumHapticFeedback()
                                userSettings.fontScaling = .small
                            }) {
                                VStack {
                                    Text("Small")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                            .buttonStyle(TileButtonStyle(isSelected: userSettings.fontScaling == .small))
                            
                            Button(action: {
                                performMediumHapticFeedback()
                                userSettings.fontScaling = .normal
                            }) {
                                HStack {
                                    Text("Medium")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                            .buttonStyle(TileButtonStyle(isSelected: userSettings.fontScaling == .normal))
                            
                            Button(action: {
                                performMediumHapticFeedback()
                                userSettings.fontScaling = .large
                            }) {
                                HStack {
                                    Text("Large")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                            .buttonStyle(TileButtonStyle(isSelected: userSettings.fontScaling == .large))
                        }
                        
                        HStack(spacing: size15) {
                            Button(action: {
                                performMediumHapticFeedback()
                                userSettings.fontScaling = .extraLarge
                            }) {
                                HStack {
                                    Text("Extra Large")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Spacer()
                                }
                                .padding(.vertical, size10)
                            }
                            .buttonStyle(RoundedBackgroundButtonStyle(isSelected: userSettings.fontScaling == .extraLarge))
                        }
                    }
                    .padding(.vertical)
                }
                
                SwiftUI.Section(header: Text("Adjust Voice Speed").font(.subheadline.bold())) {
                    VStack {
                        Slider(value: $speechRate, in: 0.1...0.7, step: 0.05)
                            .accentColor(.green)
                            .accessibilityLabel(Text("Slider"))
                        
                        HStack {
                            Image(systemName: "tortoise")
                            Spacer()
                            Text(speechSpeedDescription(for: speechRate))
                            Spacer()
                            Image(systemName: "hare")
                        }
                    }
                    .onChange(of: speechRate) { newValue in
                        performMediumHapticFeedback()
                    }
                }
                
                SwiftUI.Section {
                    NavigationLink(destination: AboutView()) {
                        VStack(alignment: .leading) {
                            Text("செயலியைப் பற்றி")
                                .font(.headline)
                            Text("About 'Tamil Lit'")
                                .font(.subheadline)
                        }
                    }
                }
                
                SwiftUI.Section {
                    NavigationLink(destination: CreditsView()) {
                        VStack(alignment: .leading) {
                            Text("Credits")
                                .font(.headline)
                            Text("For the app content")
                                .font(.subheadline)
                        }
                    }
                }
                
                SwiftUI.Section {
                    Button(action: {
                        // Action to redirect to App Store for rating
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            SKStoreReviewController.requestReview(in: windowScene)
                        }
                    }) {
                        HStack(alignment: .center, spacing: size15) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                            
                            Text("Leave a Review")
                                .font(.body.bold())
                                .foregroundStyle(Color("TextColor"))
                            
                            Spacer()
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(userSettings.darkMode ? .black : .gray.opacity(0.15))
                    .cornerRadius(size10)
                }
                
                Button(action: {
                    activeAlert = .feedback
                }) {
                    HStack(alignment: .center, spacing: size15) {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.cyan)
                        
                        Text("Send Feedback ")
                            .font(.body.bold())
                            .foregroundStyle(Color("TextColor"))
                    }
                }
                .padding(.vertical, 5)
                
                Button(action: {
                    // Action to redirect to App Store for rating
                    let url = URL(string: "https://apps.apple.com/app/tamil-lit/id6476827222")!
                    let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let rootViewController = windowScene.windows.first?.rootViewController {
                        rootViewController.present(activityController, animated: true, completion: nil)
                    }
                    
                }) {
                    HStack(alignment: .center, spacing: size15) {
                        Image(systemName: "paperplane")
                            .foregroundColor(.cyan)
                        
                        Text("Share this App")
                            .font(.body.bold())
                            .foregroundStyle(Color("TextColor"))
                    }
                }
                .padding(.vertical, 5)
            } // List
            .modifier(ListScrollIndicatorsModifier())
        }
        .alert(item: $activeAlert) { alertType in
            switch alertType {
            case .settings:
                return Alert(
                    title: Text("Enable Notifications"),
                    message: Text("Notifications are disabled. Please go to Settings to enable them."),
                    primaryButton: .default(Text("Settings")) {
                        openAppSettings()
                    },
                    secondaryButton: .cancel()
                )
            case .feedback:
                return Alert(
                    title: Text("Share Your Thoughts"),
                    message: Text("Your feedback helps us improve. Please copy the email address below to send us your thoughts."),
                    primaryButton: .default(Text("Copy email address")) {
                        UIPasteboard.general.string = "selvarajan.thangavel@gmail.com"
                    },
                    secondaryButton: .cancel(Text("Cancel"))
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(systemName: "gearshape")
                        .font(.headline)
                        .padding(.trailing, size10)
                    Text("Settings")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                
                .padding(0)
            }
        }
        .customFontScaling()
        
    }
    
    private func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
}

struct RoundedBackgroundButtonStyle: ButtonStyle {
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .font(.title2)
                .foregroundStyle(isSelected ? .green : .gray.opacity(0.3))
            
            configuration.label
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, size10)
        .background(Color.gray.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? .gray.opacity(0.5) : Color.clear, lineWidth: 2)
        )
    }
}

struct TileButtonStyle: ButtonStyle {
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center, spacing: size5) {
            Image(systemName: "checkmark.circle.fill")
                .font(.title2)
                .foregroundStyle(isSelected ? .green : .gray.opacity(0.3))
            
            configuration.label
        }
//        .frame(height: size70)
        .padding(.horizontal)
        .padding(.vertical, size10)
        .background(Color.gray.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? .gray.opacity(0.5) : Color.clear, lineWidth: 2)
        )
    }
}
