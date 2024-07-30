//
//  SettingsView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 25/07/24.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var notificationHandler: NotificationHandler
//    @State private var notificationsEnabled: Bool = UserDefaults.standard.bool(forKey: "notificationsEnabled")
    
//    @State private var darkMode = false
    @State private var showSettingsAlert = false
    
    var body: some View {
        VStack {
            List {
                SwiftUI.Section {
                    Toggle(isOn: $userSettings.notificationsEnabled) {
                        VStack(alignment: .leading) {
                            Text("தினம் ஒரு பாடல் அறிவிப்பு")
                                .font(.headline)
//                            Text("Receive a new poem every day.")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 2)
                    .onChange(of: userSettings.notificationsEnabled) { oldValue, value in
                        if value {
                            // checking if the user allow the notification from this app.
                            notificationHandler.requestNotificationPermission { granted in
                                if granted {
                                    notificationHandler.scheduleDailyNotification()
                                } else {
                                    showSettingsAlert = true
                                }
                            }
                        } else {
                            notificationHandler.cancelDailyNotification()
                        }
                    }
                    
                    Toggle(isOn: $userSettings.darkMode) {
                        VStack(alignment: .leading) {
                            Text("கரும் திரை")
                                .font(.headline)
//                            Text("Receive a new poem every day.")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 2)
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
                    NavigationLink(destination: AboutView()) {
                        VStack(alignment: .leading) {
                            Text("Credits")
                                .font(.headline)
                            Text("For the app content")
                                .font(.subheadline)
                        }
                    }
                }
                
                SwiftUI.Section {
                    NavigationLink(destination: AboutView()) {
                        VStack(alignment: .leading) {
                            Text("Tamil Keyboard")
                                .font(.headline)
                            Text("Steps to enable it on iPhone")
                                .font(.subheadline)
                        }
                    }
                }
                
                SwiftUI.Section {
                    VStack{
                        Button(action: {
                            // Action to redirect to App Store for rating
//                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//                                SKStoreReviewController.requestReview(in: windowScene)
//                            }
                        }) {
                            HStack(alignment: .center, spacing: 15) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                
                                Text("Leave a Review")
                                    .font(.body.bold())
                                    .foregroundStyle(Color("TextColor"))
//                                Text("Rate this App")
//                                    .font(.subheadline)
//                                    .foregroundColor(.black.opacity(0.75))
                                
                                Spacer()
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
//                        .background(.gray.opacity(0.15))
                        .background(userSettings.darkMode ? .black : .gray.opacity(0.15))
                        .cornerRadius(10)
                        .padding()
                        .padding(.bottom)
                        
                        Button(action: {
                            // Action to open feedback form or email
                        }) {
                            HStack(alignment: .center, spacing: 15) {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(Color("TextColor"))
                                
                                Text("Feedback / Suggession")
                                    .font(.body.bold())
                                    .foregroundStyle(Color("TextColor"))
                                
//                                Text("Share your thoughts")
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
                                
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
//                        .background(.gray.opacity(0.15))
//                        .background(userSettings.darkMode ? .cyan : .cyan.opacity(0.6))
//                        .cornerRadius(10)
                        .padding(.bottom, 10)
                        
//                        Divider()
                        
                        Button(action: {
                            // Action to redirect to App Store for rating
                        }) {
                            HStack(alignment: .center, spacing: 15) {
                                Image(systemName: "paperplane")
                                    .foregroundColor(Color("TextColor"))
                                
                                Text("Share this App")
                                    .font(.body.bold())
                                    .foregroundStyle(Color("TextColor"))
                                
//                                Text("Share with friends")
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
                                
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
//                        .background(.gray.opacity(0.15))
//                        .background(userSettings.darkMode ? .cyan : .cyan.opacity(0.6))
//                        .cornerRadius(10)
                        .padding(.bottom)
                    }
                }
                
                
            }
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .alert(isPresented: $showSettingsAlert) {
                Alert(
                    title: Text("Enable Notifications"),
                    message: Text("Notifications are disabled. Please go to Settings to enable them."),
                    primaryButton: .default(Text("Settings")) {
                        openAppSettings()
                    },
                    secondaryButton: .cancel()
                )
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

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
