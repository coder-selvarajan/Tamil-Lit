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
                
                SwiftUI.Section(header: Text("Choose your theme").font(.subheadline.bold())) {
                    VStack(spacing: size15) {
                        Button(action: {
                            userSettings.darkMode = false
                            themeManager.setTheme(.primary)
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
                        .buttonStyle(RoundedBackgroundButtonStyle(isSelected: themeManager.selectedTheme == .primary))
                        
                        Button(action: {
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
                
                SwiftUI.Section(header: Text("Adjust Font Size").font(.subheadline.bold())) {
                    VStack(spacing: size15) {
                        HStack(spacing: size15) {
                            Button(action: {
                                userSettings.fontScaling = .small
                            }) {
                                VStack {
                                    Text("Small")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                            .buttonStyle(TileButtonStyle(isSelected: userSettings.fontScaling == .small))
                            
                            Button(action: {
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
                
//                SwiftUI.Section(header: Text("Adjust Content Scaling").font(.subheadline.bold())) {
//                    VStack {
//                        Picker("Content Size", selection: $userSettings.fontScaling) {
//                            ForEach(FontScalingOption.allCases) { option in
//                                Text(option.rawValue.capitalized)
//                                    .tag(option)
//                                    .font(.system(size: 20).bold())
//                            }
//                        }
//                        .pickerStyle(SegmentedPickerStyle())
//                        .frame(maxWidth: .infinity)
//                    }
//                    .padding(.vertical, size10)
//                }
                
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

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
