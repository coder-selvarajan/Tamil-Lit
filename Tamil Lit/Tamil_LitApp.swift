//
//  Tamil_LitApp.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI
import SwiftData

@main
struct Tamil_LitApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    NavigationLink(destination: KuralHomeView()) {
                        Text("திருக்குறள்")
                            .padding(.vertical, 15)
                    }
                    
                    NavigationLink(destination: AthichudiHomeView()) {
                        Text("ஆத்தி சூடி")
                            .padding(.vertical, 15)
                    }
                }
                .navigationBarTitle("Tamil Lit")
                .navigationBarTitleDisplayMode(.inline)
            }.preferredColorScheme(.light)
        }
    }
}
