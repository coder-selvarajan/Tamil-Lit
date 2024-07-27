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
                }
                
                
                SwiftUI.Section {
                    NavigationLink(destination: AboutView()) {
                        VStack(alignment: .leading) {
                            Text("செயலியைப் பற்றி")
                                .font(.headline)
                            Text("About this app.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                SwiftUI.Section {
                    VStack{
                        Button(action: {
                            // Action to redirect to App Store for rating
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                SKStoreReviewController.requestReview(in: windowScene)
                            }
                        }) {
                            VStack(alignment: .center) {
                                Text("செயலியை மதிப்பிடு")
                                    .font(.headline)
                                    .foregroundStyle(Color("TextColor"))
                                Text("Rate this app")
                                    .font(.subheadline)
                                    .foregroundColor(Color("TextColor").opacity(0.75))
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.yellow.opacity(0.6))
                        .cornerRadius(10)
                        .padding()
                        
                        Button(action: {
                            // Action to open feedback form or email
                        }) {
                            HStack(alignment: .center, spacing: 10) {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(Color("TextColor"))
                                
                                Text("கருத்துக்களை பகிரவும்")
                                    .font(.headline)
                                    .foregroundStyle(Color("TextColor"))
                                
//                                Text("Share your thoughts")
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.yellow.opacity(0.6))
                        .cornerRadius(10)
                        .padding()
                        
                        Button(action: {
                            // Action to redirect to App Store for rating
                        }) {
                            HStack(alignment: .center, spacing: 10) {
                                Image(systemName: "paperplane")
                                    .foregroundColor(Color("TextColor"))
                                
                                Text("செயலியை பகிரவும்")
                                    .font(.headline)
                                    .foregroundStyle(Color("TextColor"))
                                
//                                Text("Share with friends")
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.yellow.opacity(0.6))
                        .cornerRadius(10)
                        .padding()
                    }
                }
                
                
            }
            .navigationBarTitle("Settings")
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
