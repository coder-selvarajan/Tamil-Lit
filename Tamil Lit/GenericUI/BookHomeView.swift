//
//  BookHomeView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 02/07/24.
//

import SwiftUI

struct BookHomeView: View {
    let colorTheme: Color
    let bookName: String
    
    var body: some View {
        ZStack {
            colorTheme.opacity(0.2).ignoresSafeArea()
            
            CategoryListView(colorTheme: colorTheme, bookName: bookName)
        }
        
    }
}

//#Preview {
//    BookHomeView()
//}
