//
//  SettingsView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 25/07/24.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var bookManager: BookManager
    
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var notificationHandler: NotificationHandler
    
    @State private var activeAlert: ActiveAlert?
    
    enum ActiveAlert: Identifiable {
        case settings, feedback
        
        var id: Int {
            hashValue
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
                            Text("Daily Push Notification")
                                .font(.footnote)
                        }
                    }
                    .padding(.vertical, 2)
                    .onChange(of: userSettings.notificationsEnabled) { value in
                        if value {
                            // checking if the user allow the notification from this app.
                            notificationHandler.requestNotificationPermission { granted in
                                if granted {
                                    notificationHandler.scheduleDailyNotification()
                                } else {
                                    activeAlert = .settings
                                }
                            }
                        } else {
                            notificationHandler.cancelDailyNotification()
                        }
                    }
                    
//                    Toggle(isOn: $userSettings.darkMode) {
//                        VStack(alignment: .leading) {
//                            Text("கரும் திரை")
//                                .font(.headline)
//                        }
//                    }
//                    .padding(.vertical, 2)
                    
                }
                
//                SwiftUI.Section(header: Text("Select Theme")) {
//                    Button(action: {
//                        userSettings.darkMode = false
//                        themeManager.setTheme(.primary)
//                        bookManager.updateBooks(with: themeManager.currentTheme)
//                    }) {
//                        Text("Primary")
//                            .foregroundColor(themeManager.currentTheme == Themes.primaryTheme ? .blue : .primary)
//                    }
//                    Button(action: {
//                        userSettings.darkMode = false
//                        themeManager.setTheme(.light)
//                        bookManager.updateBooks(with: themeManager.currentTheme)
//                    }) {
//                        Text("Light ")
//                            .foregroundColor(themeManager.currentTheme == Themes.lightTheme ? .blue : .primary)
//                    }
//                    Button(action: {
//                        userSettings.darkMode = true
//                        themeManager.setTheme(.dark)
//                        bookManager.updateBooks(with: themeManager.currentTheme)
//                    }) {
//                        Text("Dark ")
//                            .foregroundColor(themeManager.currentTheme == Themes.darkTheme ? .blue : .primary)
//                    }
//                }
                
                SwiftUI.Section(header: Text("Select Theme")) {
                    HStack(spacing: 16) {
                        Button(action: {
                            userSettings.darkMode = false
                            themeManager.setTheme(.primary)
                            bookManager.updateBooks(with: themeManager.currentTheme)
                        }) {
                            Text("Primary")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(RoundedBackgroundButtonStyle(isSelected: themeManager.selectedTheme == .primary))
                        
                        Button(action: {
                            userSettings.darkMode = false
                            themeManager.setTheme(.light)
                            bookManager.updateBooks(with: themeManager.currentTheme)
                        }) {
                            Text("Light")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(RoundedBackgroundButtonStyle(isSelected: themeManager.selectedTheme == .light))
                        
                        Button(action: {
                            userSettings.darkMode = true
                            themeManager.setTheme(.dark)
                            bookManager.updateBooks(with: themeManager.currentTheme)
                        }) {
                            Text("Dark")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(RoundedBackgroundButtonStyle(isSelected: themeManager.selectedTheme == .dark))
                    }
                    .padding(.vertical)
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
                    NavigationLink(destination: TamilKeyboardInstructionView()) {
                        VStack(alignment: .leading) {
                            Text("Tamil Keyboard")
                                .font(.headline)
                            Text("How to enable it on iPhone?")
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
                    let url = URL(string: "https://apps.apple.com/in/app/board-brain/id6482852806")!
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
        configuration.label
            .padding()
            .background(isSelected ? Color.cyan : Color.gray.opacity(0.2))
            .foregroundColor(isSelected ? .white : .primary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.primary, lineWidth: 1)
//            )
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
