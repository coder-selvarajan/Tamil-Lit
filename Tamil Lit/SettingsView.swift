//
//  SettingsView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 25/07/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var dailyPoemEnabled = false
    @State private var darkMode = false

    var body: some View {
        VStack {
            List {
                SwiftUI.Section {
                    Toggle(isOn: $dailyPoemEnabled) {
                        VStack(alignment: .leading) {
                            Text("தினம் ஒரு பாடல் அறிவிப்பு")
                                .font(.headline)
//                            Text("Receive a new poem every day.")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
                        }
                    }
                    
                    Toggle(isOn: $darkMode) {
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
                        }) {
                            VStack(alignment: .center) {
                                Text("செயலியை மதிப்பிடு")
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                Text("Rate this app")
                                    .font(.subheadline)
                                    .foregroundColor(.black.opacity(0.75))
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
                                    .foregroundColor(.black)
                                
                                Text("கருத்துக்களை பகிரவும்")
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                
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
                                    .foregroundColor(.black)
                                
                                Text("செயலியை பகிரவும்")
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                
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
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
