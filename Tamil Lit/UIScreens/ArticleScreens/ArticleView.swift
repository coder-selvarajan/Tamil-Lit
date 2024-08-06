//
//  ArticleView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/07/24.
//

import SwiftUI
import MarkdownUI

struct ArticleView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State var markdownContent: String = ""
    @State var fileName: String = ""
    
    // Function to load markdown file content
    func loadMarkdownFile(named fileName: String) -> String? {
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "md"),
           let fileContents = try? String(contentsOf: fileURL) {
            return fileContents
        }
        return nil
    }
    
    var body: some View {
        ScrollView {
            Markdown(markdownContent)
                .font(.body)
                .textSelection(.enabled)
                .padding(size20)
        }
        .onAppear() {
            markdownContent = loadMarkdownFile(named: fileName) ?? ""
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                SpeakButtonView(textContent: $markdownContent)
                    .padding(.vertical, 5)
                    .background(themeManager.selectedTheme == .primary ? .gray.opacity(0.3) : .gray.opacity(0.2))
                    .cornerRadius(8)
            }
        } // toolbar
        .customFontScaling()
    }
}

#Preview {
    ArticleView()
}
