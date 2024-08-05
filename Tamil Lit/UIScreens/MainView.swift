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
    
//    @State private var navigationPath = NavigationPath()
//    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            NavigationView {
                if hasCompletedOnboarding {
                    HomeView()
                } else {
                    // OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
                }
            }
            .onAppear {
                launchCount += 1  // Incrementing the launch count
                checkAndPromptForReview()
            }
        }
        
//        ZStack {
//            if #available(iOS 16.0, *) {
//                NavigationStack {
//                    if hasCompletedOnboarding {
//                        HomeView()
//                    } else {
//                        //                    OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
//                    }
//                }
//                .onAppear(){
//                    //                TelemetryDeck.signal(
//                    //                    "Page Load",
//                    //                    parameters: [
//                    //                        "app": "BoardBrain",
//                    //                        "event": "page load",
//                    //                        "identifier":"main-view",
//                    //                        "viewName":"Main View"
//                    //                    ]
//                    //                )
//                }
//                .onAppear {
//                    launchCount += 1  // Incrementing the launch count
//                    checkAndPromptForReview()
//                }
//            } else {
//                // Fallback on earlier versions
//                NavigationView {
//                    if hasCompletedOnboarding {
//                        HomeView()
//                    } else {
//                        //                    OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
//                    }
//                }
//                .onAppear {
//                    launchCount += 1  // Incrementing the launch count
//                    checkAndPromptForReview()
//                }
//            }
//        }
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
