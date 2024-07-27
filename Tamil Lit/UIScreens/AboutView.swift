//
//  AboutView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 25/07/24.
//

import SwiftUI
import StoreKit

struct AboutView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Image("114")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Text("Tamil Lit")
                        .font(.custom("Quicksand", size: 22))
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                    Spacer()
                }
                
                Text("Discover the Rich Heritage of Tamil Literature with TamilLit")
                    .fontWeight(.bold)
                
                Text("Welcome to TamilLit, your gateway to the timeless treasures of Tamil literature. Dive into a curated collection of classical Tamil texts, including Thirukural, Aathisudi, Naladiyar, and more. Whether you are a literature enthusiast, a student, or simply curious about the profound wisdom of Tamil writings, TamilLit offers an immersive experience tailored just for you.")
                    .font(.body)
                
                Divider()
                
                Text("Features")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading, spacing: 10) {
                    FeatureView(title: "Daily Poem", 
                                description: "Start your day with a new poem delivered right to your app.")
                    FeatureView(title: "Comprehensive Collection", 
                                description: "Explore a vast array of literary works, from ancient classics to beloved proverbs.")
                    FeatureView(title: "User-Friendly Interface",
                                description: "Navigate effortlessly through well-organized categories and intuitive search functionality.")
                    FeatureView(title: "Personalized Experience",
                                description: "Customize your reading preferences with theme options, language settings, and notification controls.")
                    FeatureView(title: "Engage and Share",
                                description: "Rate the app, send feedback, and share your favorite passages with friends and family.")
                }
                
                Divider()
                
                Text("Embark on a literary journey and uncover the profound wisdom and poetic beauty of Tamil literature. Download TamilLit today and enrich your understanding of this ancient and vibrant literary tradition.")
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("App Information")
                        .font(.body)
                        .fontWeight(.semibold)
                    Text("Tamil Lit is an ad-free app that requires no internet connectivity. It does not require access to any information from the user's phone.")
                        .font(.caption)
                        .padding(.bottom)
                    Text("This app is built using the SwiftUI framework.")
                        .font(.caption)
                    HStack {
                        Link("Developer Website", destination: URL(string: "https://selvarajan.in")!)
                            .font(.caption)
                            .foregroundColor(.blue)
                        Text(" | ")
                            .font(.footnote)
                            .foregroundStyle(Color("TextColorWhite").opacity(0.7))
                        Link("Github Profile", destination: URL(string: "https://github.com/coder-selvarajan")!)
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .padding(.horizontal)
        .background(Color("TextColorWhite").opacity(0.20))
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("About").font(.title3)
                        .foregroundColor(Color("TextColorWhite"))
                        .padding(.horizontal, 10)
                    Spacer()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: windowScene)
                    }
                }) {
                    HStack {
                        Image(systemName: "heart.fill")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        Text("Leave a Review")
                    }
                }
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
                    .fontWeight(.semibold)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    AboutView()
}
