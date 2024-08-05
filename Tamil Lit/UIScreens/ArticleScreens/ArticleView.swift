//
//  ArticleView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/07/24.
//

import SwiftUI
import MarkdownUI

struct ArticleView: View {
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
                .textSelection(.enabled)
                .padding()
        }
        .onAppear() {
            markdownContent = loadMarkdownFile(named: fileName) ?? ""
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ArticleView()
}
