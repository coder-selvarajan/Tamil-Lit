//
//  HTMLLabel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/07/24.
//

import SwiftUI
import UIKit

struct HTMLLabel: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        guard let attributedString = try? NSAttributedString(
            data: Data(htmlContent.utf8),
            options: [.documentType: NSAttributedString.DocumentType.html,
                      .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil) else {
            uiView.attributedText = nil
            return
        }
        uiView.attributedText = attributedString
    }
}
