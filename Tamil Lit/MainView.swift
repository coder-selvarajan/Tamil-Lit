//
//  MainView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 01/06/24.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    @State private var navigationPath = NavigationPath()
    @Environment(\.presentationMode) var presentationMode
    
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
//            NavigationStack {
                
                HomeView()
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        Button {
                            // Go to home page
                            print(navigationPath.count)
//                            navigationPath.removeAll()
//                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "house.fill")
                                .font(.title2)
                                .foregroundStyle(.black.opacity(0.8))
                                .padding(15)
                        }
                        .background(.white)
                        .cornerRadius(10.0)
                        .shadow(radius: 10)
                        .padding(20)
                        
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
//            }
            
//            VStack(spacing: 0) {
//                TabView(selection: $selectedTab) {
//                    HomeView()
//                        .tabItem {
//                            Image(systemName: "house")
//                            Text("Home")
//                        }
//                        .tag(0)
//                    
//                    HomeViewOld()
//                        .tabItem {
//                            Image(systemName: "star")
//                            Text("Favourites")
//                        }
//                        .tag(1)
//                    
//                    HomeViewOld()
//                        .tabItem {
//                            Image(systemName: "gear")
//                            Text("Settings")
//                        }
//                        .tag(2)
//                    
//                    HomeViewOld()
//                        .tabItem {
//                            Image(systemName: "star")
//                            Text("Favourites")
//                        }
//                        .tag(3)
//                }
//                .edgesIgnoringSafeArea(.bottom)
//                
//                Spacer(minLength: 0)
//            }
//            
//            VStack {
//                Spacer()
//                HStack {
//                    TabButton(icon: "house.fill", tabIndex: 0, selectedTab: $selectedTab)
//                    Spacer()
////                    TabButton(icon: "sparkles.square.filled.on.square", tabIndex: 1, selectedTab: $selectedTab)
////                    Spacer()
//                    TabButton(icon: "bookmark.fill", tabIndex: 2, selectedTab: $selectedTab)
//                    Spacer()
//                    TabButton(icon: "gearshape.fill", tabIndex: 3, selectedTab: $selectedTab)
//                }
//                .padding(5)
//                .background(
//                    RoundedRectangle(cornerRadius: 20)
//                        .fill(.white.opacity(0.95))
//                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 20)
//                                .stroke(Color(.systemGray4), lineWidth: 0.25)
//                        )
//                )
//                .padding(.horizontal)
//                .padding(.bottom, 25)
//            }.ignoresSafeArea()
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
                .font(.title3)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 20)
                .foregroundColor(selectedTab == tabIndex ? Color.black : Color.gray)
                .padding()
        }
    }
}


#Preview {
    MainView()
}
