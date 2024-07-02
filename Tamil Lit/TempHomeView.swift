//
//  TempHomeView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 02/07/24.
//

import SwiftUI

struct TempHomeView: View {
    var body: some View {
        NavigationStack {
            NavigationLink(destination: BookHomeView(colorTheme: .blue, bookName: "திருக்குறள்")) {
                Text("Read திருக்குறள்")
            }
            Divider()
            
            NavigationLink(destination: BookHomeView(colorTheme: .green, bookName: "திருக்குறள்")) {
                Text("Read Naladiyar")
            }
            
            Divider()
            
            NavigationLink(destination: BookHomeView(colorTheme: .red, bookName: "திருக்குறள்")) {
                Text("Read Manimegalai")
            }
        }
    }
}

#Preview {
    TempHomeView()
}
