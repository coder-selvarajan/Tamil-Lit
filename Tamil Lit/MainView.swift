//
//  MainView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 01/06/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(0)
                    
                    HomeViewOld()
                        .tabItem {
                            Image(systemName: "star")
                            Text("Favourites")
                        }
                        .tag(1)
                    
                    HomeViewOld()
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                        .tag(2)
                }
                .edgesIgnoringSafeArea(.bottom)
                
                Spacer(minLength: 0)
            }
            
            VStack {
                Spacer()
                HStack {
                    TabButton(icon: "house.fill", tabIndex: 0, selectedTab: $selectedTab)
                    Spacer()
                    TabButton(icon: "star.fill", tabIndex: 1, selectedTab: $selectedTab)
                    Spacer()
                    TabButton(icon: "gearshape.fill", tabIndex: 2, selectedTab: $selectedTab)
                }
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white.opacity(0.95))
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(.systemGray4), lineWidth: 0.25)
                        )
                )
                .padding(.horizontal)
                .padding(.bottom, 25)
            }.ignoresSafeArea()
        }
    }
}

struct TabButton: View {
    let icon: String
    let tabIndex: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        Button(action: {
            selectedTab = tabIndex
        }) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 20)
                .foregroundColor(selectedTab == tabIndex ? Color.black : Color.gray)
                .padding()
        }
    }
}


#Preview {
    MainView()
}
