//
//  TamilKeyboardPopupView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 12/08/24.
//

import SwiftUI
import MarkdownUI

struct TamilKeyboardPopupView: View {
    @Binding var isPresented: Bool
    
    let content =
    """
    ### Tamil Keyboard Settings
    
    Enable the Tamil keyboard using the instructions below. You can ignore this if it's already enabled.
    
    - Open the **Settings** app on your iPhone.
    
    - Go to **General** › **Keyboard** › **Keyboards** › **Add New Keyboard**
    
    - Scroll down and select **Tamil**.
    
    - If you see a list of keyboards within Tamil, select the appropriate one (e.g., **Tamil99** or **Anjal**). If not, the Tamil keyboard will be enabled directly.
    """

    var body: some View {
//        ZStack {
            VStack(spacing: 20) {
                Markdown(content)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                
                Button(action: {
                    guard let url = URL(string: "App-Prefs:root=General") else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }) {
                    Text("Go to Settings")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(Color("TextColor"))
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color("TextColorWhite"))
            .cornerRadius(12)
            .shadow(radius: 10)
            .padding(.horizontal, 20)
            .overlay(
                CloseButton() {
                    isPresented = false
                }.padding(.trailing), alignment: .topTrailing
                    
            )
            
//            VStack {
//                HStack {
//                    Spacer()
//                    
//                    CloseButton() {
//                        isPresented = false
//                    }
//                }
//                Spacer()
//            }
//        }
    }
}
