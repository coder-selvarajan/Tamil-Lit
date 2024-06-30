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
    let persistenceController = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            CategoryListView()
//            MainCategoryListView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
            
//            MainView()
                .preferredColorScheme(ColorScheme.light)
        }
    }
}
