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
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("\(markdownContent.prefix(30))")
        .accessibilityLabel("Article View")
        .onAppear() {
            markdownContent = loadMarkdownFile(named: fileName) ?? ""
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                SpeakButtonView(textContent: $markdownContent, subContentList: Binding.constant(nil))
            }
        } // toolbar
        .customFontScaling()
    }
}

#Preview {
    ArticleView()
}
