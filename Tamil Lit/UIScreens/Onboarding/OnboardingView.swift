//
//  OnboardingView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 11/08/24.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    
    @State private var selectedIndex = 0
    private let totalPages = 4

    var body: some View {
        VStack {
            // Navigation Buttons at the Top
            HStack {
                // Back Button
                
                Button(selectedIndex > 0 ? " ← Back" : " ") {
                    withAnimation {
                        selectedIndex -= 1
                    }
                }
                .padding()
            

                Spacer()

                // Skip Button
                Button(selectedIndex < 4 ? "Skip": "Close") {
                    // Navigate to the Home View
                    hasCompletedOnboarding = true
                }
                .font(Font.headline.weight(.semibold))
//                .fontWeight(Font.Weight.semibold)
                .padding()
                .frame(width: 100, height: 40)
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            
            Spacer()
            
            TabView(selection: $selectedIndex) {
                PageView(imageName: "AppIcon", title: "Welcome to Tamil Lit", description: "An app dedicated to providing rich information about Tamil literature. Enjoy a seamless and enjoyable reading experience with our variety of features.")
                    .tag(0)
                
                PageView(imageName: "collection", title: "Explore Our Collection", description: "Tamil Lit includes 10 renowned literature books, each with multiple explanations. Stay inspired with daily poem notifications, and discover new poems effortlessly with our random poem display feature.")
                    .tag(1)
                
                PageView(imageName: "bookmarking", title: "Bookmark, Share, and Capture", description: "Easily bookmark your favorite poems, share the beauty of Tamil literature with friends, and capture the essence of any poem with our screenshot feature.")
                    .tag(2)
                
                PageView(imageName: "search", title: "Search and Customize", description: "Search for poems using Tamil words, filter by books, and enjoy a comfortable reading experience with dark mode, text-to-speech, theme options, and font scaling adjustments.")
                    .tag(3)
                
                PageView(imageName: "progress_status", title: "Track Your Progress", description: "Monitor your reading progress across different books and continue exploring the profound and timeless world of Tamil literature.")
                    .tag(4)
            }
            .tabViewStyle(PageTabViewStyle())
            .ignoresSafeArea(edges: .all)
            .padding()

            Spacer()
            
            // Next and Finish Buttons
            HStack {
                Spacer()
                if selectedIndex < totalPages {
                    Button(action: {
                        withAnimation {
                            selectedIndex += 1
                        }
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Next")
                                .fontWeight(Font.Weight.semibold)
                            Spacer()
                        }
                    })
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                } else {
                    Button(action: {
                        hasCompletedOnboarding = true
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Get started")
                                .fontWeight(Font.Weight.semibold)
                            Spacer()
                        }
                    })
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                }
            }.padding()
            Spacer()
        }
        .onAppear() {
//            TelemetryDeck.signal(
//                "Page Load",
//                parameters: [
//                    "app": "BoardBrain",
//                    "event": "page load",
//                    "identifier":"onboarding-view",
//                    "viewName":"Onboarding View"
//                ]
//            )
        }
        .foregroundColor(.white)
        .background(Color.white.opacity(0.20))
        .navigationTitle(Text(""))
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
    }
}

struct PageView: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
        .foregroundStyle(.black)
        .padding()
    }
}

struct OnboardingPage: View {
    let title: String
    let description: String
    let imageName: String
    var systemImage: Bool = true
    let imageWidth: CGFloat = UIScreen.main.bounds.size.height * 0.125
    let iconWidth: CGFloat = UIScreen.main.bounds.size.height * 0.1
    
    var body: some View {
        VStack {
            Spacer()
            if systemImage {
                Image(systemName: imageName) // Replace 'systemName' with 'imageName' for custom images
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconWidth)
                    .padding()
            }
            else {
                Image(imageName) // Replace 'systemName' with 'imageName' for custom images
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageWidth)
                    .padding()
            }
            Spacer()
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            Text(description)
                .font(.body)
                .padding()
            Spacer()
        }
    }
}
