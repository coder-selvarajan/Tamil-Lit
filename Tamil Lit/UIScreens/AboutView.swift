//
//  AboutView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 25/07/24.
//

import SwiftUI
import StoreKit

struct AboutView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: size20) {
                HStack {
                    Image("logo400")
                        .resizable()
                        .frame(width: size50, height: size50)
                        .clipShape(RoundedRectangle(cornerRadius: size15))
                    
                    Text("Tamil Lit")
                        .font(.custom("Quicksand", size: 24))
                        .fontWeight(.semibold)
                        .padding(.horizontal, size10)
                    Spacer()
                }.padding(.top)
                
                // Main content
                VStack(alignment: .leading, spacing: size20) {
                    Text("Welcome to Tamil Lit, your comprehensive app for exploring the richness of Tamil literature. Designed for a seamless and enjoyable reading experience, our app offers a range of features:")
                        .font(.body)
                    
                    VStack(alignment: .leading, spacing: size20) {
                        FeatureView(title: "Curated Collection", description: "Tamil Lit features 10 renowned books like Thirukural, Naaladiyar, and Athichudi, each with multiple explanations to deepen your understanding.")
                        FeatureView(title: "Daily Inspiration", description: "Receive a new poem every day with our 'Daily Poem' notifications, keeping you inspired.")
                        FeatureView(title: "Discover and Bookmark", description: "Effortlessly explore random poems and bookmark your favorites for easy access later. Organize your bookmarks by date or book.")
                        FeatureView(title: "Share and Capture", description: "Share the beauty of Tamil literature with friends directly from the app, or capture the essence of any poem with a screenshot.")
                        FeatureView(title: "Powerful Search", description: "Search across all books using Tamil words, with the option to filter results by specific titles.")
                        FeatureView(title: "Personalized Experience", description: "Customize your reading experience with three theme options—Colorful, Monochrome, and Dark. Text-to-speech is available on poem and article pages, and your reading progress is tracked on the book banners. Additionally, you can adjust font scaling for optimal readability.",
                        showDivider: false)
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    Text("Tamil Lit is your gateway to the timeless beauty of classical Tamil poems and their interpretations. Dive in and explore the profound world of Tamil literature.")
                        .font(.body)
                }
                
                Divider()
                    .padding(.vertical, 5)
                
                // Additional App Information
                VStack(alignment: .leading, spacing: 5) {
                    Text("App Information")
                        .font(.body)
                        .fontWeight(.semibold)
                    Text("Tamil Lit is an ad-free app that works without internet connectivity and does not require access to any personal information on your device. ")
                        .font(.body)
                        .padding(.bottom)
                    Text("The app is built using Apple's SwiftUI framework.")
                        .font(.body)
                    HStack {
                        Link("Developer Website", destination: URL(string: "https://selvarajan.in")!)
                            .font(.body)
                            .foregroundColor(.blue)
                        
                        Spacer()
                    }
                }
                .padding(.bottom, size20)
                
                Spacer()
            }
        }
        .padding(.horizontal)
        .background(Color("TextColorWhite").opacity(0.20))
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("About").font(.title3)
                        .foregroundColor(Color("TextColor"))
                        .padding(.horizontal, size10)
                    Spacer()
                }
            }
            
            ToolbarItem {
                Button(action: {
                    // Action to redirect to App Store for rating
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: windowScene)
                    }
                }) {
                    HStack(alignment: .center, spacing: size15) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                        
                        Text("Leave a Review")
                            .font(.body.bold())
                            .foregroundStyle(Color("TextColor"))
                        
                    }
                }
            }
        } //toolbar
        .customFontScaling()
    }
}

struct FeatureView: View {
    var title: String
    var description: String
    var showDivider: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(title):")
                .font(.body.bold())
            Text(description)
                .font(.body)
            
            if showDivider {
                Divider().padding(.top, size10)
            }
        }
        
    }
}

#Preview {
    AboutView()
}
