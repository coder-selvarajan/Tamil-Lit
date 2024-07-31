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
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image("114")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Text("Tamil Lit")
                        .font(.custom("Quicksand", size: 24))
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                    Spacer()
                }.padding(.top)
                
                // Main content
                VStack(alignment: .leading, spacing: 20) {
                    Text("Welcome to Tamil Lit, an app dedicated to providing rich information about Tamil literature. Our app is designed to offer a seamless and enjoyable reading experience with a variety of features:")
                        .font(.body)
                    
                    FeatureView(title: "Extensive Collection", description: "Tamil Lit currently includes 10 renowned literature books, each featuring multiple explanations. Our library is continuously expanding, with more books to be added in the future.")
                    FeatureView(title: "Daily Poem Notifications", description: "Stay inspired with our 'Daily Poem' notification feature, delivering a new poem to your device every day.")
                    FeatureView(title: "Random Poem Display", description: "Discover new poems effortlessly with our random poem display feature, which showcases poems from selected books.")
                    FeatureView(title: "Bookmarking", description: "Easily bookmark your favorite poems and revisit them later. You can organize your bookmarks by date and book.")
                    FeatureView(title: "Sharing", description: "Share the beauty of Tamil literature with friends. Tamil Lit allows you to share poem content directly from the app.")
                    FeatureView(title: "Screenshot Capture", description: "Capture the essence of any poem, along with its explanations, by taking a screenshot within the app.")
                    FeatureView(title: "Advanced Search", description: "Our advanced search functionality lets you search for poems using Tamil words. You can also filter your search by selecting specific books.")
                    FeatureView(title: "Dark Mode", description: "Enjoy reading in any lighting condition with our dark mode feature, providing a comfortable reading experience in low light.")
                    
                    Text("Tamil Lit is your gateway to exploring the profound and timeless world of Tamil literature. Dive in and discover the beauty of classical Tamil poems and their interpretations.")
                        .font(.body)
                }
//                .padding(.bottom, paddingSize)
                
                Divider()
                    .padding(.vertical, 5)
                
                // Additional App Information
                VStack(alignment: .leading, spacing: 5) {
                    Text("App Information")
                        .font(.body)
                        .fontWeight(.semibold)
                    Text("Tamil Lit is an ad-free app that requires no internet connectivity. It does not require access to any information from the user's phone.")
                        .font(.body)
                        .padding(.bottom)
                    Text("This app is built using the SwiftUI framework.")
                        .font(.body)
                    HStack {
                        Link("Developer Website", destination: URL(string: "https://selvarajan.in")!)
                            .font(.body)
                            .foregroundColor(.blue)
                        Text(" | ")
                            .font(.body)
                            .foregroundColor(Color("TextColor").opacity(0.7))
                        Link("Github Profile", destination: URL(string: "https://github.com/coder-selvarajan")!)
                            .font(.body)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, paddingSize)
                
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
                        .padding(.horizontal, 10)
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
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                        
                        Text("Leave a Review")
                            .font(.body.bold())
                            .foregroundStyle(Color("TextColor"))
                        
                    }
                }
//                .padding()
//                .background(userSettings.darkMode ? .black : .gray.opacity(0.15))
//                .cornerRadius(10)
            }
            
        } //toolbar
    }
}

struct FeatureView: View {
    var title: String
    var description: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.body)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    AboutView()
}
