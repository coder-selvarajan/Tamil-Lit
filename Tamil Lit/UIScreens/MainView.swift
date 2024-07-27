//
//  MainView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 01/06/24.
//

import SwiftUI

struct MainView: View {
//    @State private var selectedTab = 0
    
    @State private var navigationPath = NavigationPath()
    @Environment(\.presentationMode) var presentationMode
    
//    init() {
//        UITabBar.appearance().isHidden = true
//    }
    
    var body: some View {
        ZStack {
            HomeView()
        }
    }
}

//struct TabButton: View {
//    let icon: String
//    let tabIndex: Int
//    @Binding var selectedTab: Int
//    
//    var body: some View {
//        Button(action: {
//            selectedTab = tabIndex
//        }) {
//            Image(systemName: icon)
//                .font(.title3)
//                .foregroundColor(selectedTab == tabIndex ? Color("TextColor") : Color.gray)
//                .padding()
//        }
//    }
//}


#Preview {
    MainView()
}
