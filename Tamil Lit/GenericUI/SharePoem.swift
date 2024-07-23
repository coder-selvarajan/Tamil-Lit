//
//  SharePoem.swift
//  Tamil Lit
//
//  Created by Selvarajan on 23/07/24.
//

import SwiftUI

struct SharePoem: View {
    @State var poem: Poem?
    @State private var isSharing = false
    
    var body: some View {
        Button {
            isSharing = true
        } label: {
            HStack(spacing: 5) {
                Image(systemName: "paperplane")
                Text("பகிர்")
            }
            .font(.subheadline)
            .foregroundStyle(.black)
        }
        .padding(.leading, 10)
        .sheet(isPresented: $isSharing, onDismiss: {
            print("Dismissed")
        }) {
            ActivityView(activityItems: [scoreText()])
        }
    }
    
    func scoreText() -> String {
        if let poem = poem {
            return """
            \(poem.bookname ?? "")
            
            \(poem.book?.poemType ?? "பாடல் ") \(poem.number) :
            \(poem.poem ?? "")
            """
        }
        
        return ""
    }
}

// UIViewControllerRepresentable wrapper
struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
    
    typealias UIViewControllerType = UIActivityViewController
}

