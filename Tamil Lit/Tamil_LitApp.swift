//
//  Tamil_LitApp.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI
//import SwiftData

@main
struct Tamil_LitApp: App {
    let persistenceController = CoreDataManager.shared
    
    @State private var loadingStatus: LoadingStatus  = .idle
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(ColorScheme.light)
                .environment(\.managedObjectContext, persistenceController.viewContext)
                .environment(\.showLoading) { loadingStatus in
                    self.loadingStatus = loadingStatus
                }
                .overlay(alignment: .center) {
                    if loadingStatus == .loading {
                        LoadingView()
                    }
                }
        }
    }
}
