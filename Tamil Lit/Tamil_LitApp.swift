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
                    NavigationLink(destination: HomeView()) {
                        Text("Thirukural")
                    }
                    
                    NavigationLink(destination: HomeView()) {
                        Text("Aathisudi")
                    }
                }
                .navigationBarTitle("Tamil Lit App")
                .navigationBarTitleDisplayMode(.inline)
            }.preferredColorScheme(.light)
        }
    }
}
