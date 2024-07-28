//
//  HTMLView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/07/24.
//

import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable {
    
    let htmlContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    private func fontSize() -> Int {
        // Adjust this value based on the desired default font size
        return 16
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let styledHTML = """
                <html>
                <head>
                <style>
                body {
                    font-size: \(fontSize())px;
                    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
                    padding: 16px;
                }
                </style>
                </head>
                <body>
                \(htmlContent)
                </body>
                </html>
                """
        uiView.loadHTMLString(styledHTML, baseURL: nil)
    }
    
}
