//
//  MainView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 01/06/24.
//

import SwiftUI
import StoreKit

struct MainView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = true
    @AppStorage("launchCount") var launchCount: Int = 0
    
    var body: some View {
        ZStack {
            NavigationView {
                HomeView()
            }
            .onAppear {
                launchCount += 1  // Incrementing the launch count
                checkAndPromptForReview()
            }
        }
    }
    
    private func checkAndPromptForReview() {
        if launchCount == 5 || launchCount == 20 {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
}

#Preview {
    MainView()
}
