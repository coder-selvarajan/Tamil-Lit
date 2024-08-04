//
//  SharePoem.swift
//  Tamil Lit
//
//  Created by Selvarajan on 23/07/24.
//

import SwiftUI

struct SharePoem: View {
    @EnvironmentObject var userSettings: UserSettings
    
    @Binding var poem: Poem
    @Binding var explanations: [Explanation]
//    @State var tintColor: Color
    
    @State private var isSharing = false
    
    func getCategoryDisplay() -> String {
//        guard let poem = poem else { return "" }
        
        let mainCat = poem.maincategoryname ?? ""
        let subCat = poem.subcategoryname ?? ""
        let sec = poem.sectionname ?? ""
        
        if sec != ""  {
            return "\nவகை: \(mainCat) - \(subCat) - \(sec)"
        } else if subCat != "", !subCat.starts(with: "பாடல்") {
            return "\nவகை: \(mainCat) - \(subCat)"
        } else if mainCat != "", !mainCat.starts(with: "பாடல்") {
            return "\nவகை: \(mainCat)"
        }
        return ""
    }
    
    var body: some View {
        Button {
            isSharing = true
        } label: {
            HStack(spacing: 5) {
                Image(systemName: "paperplane")
                Text("பகிர்")
            }
            .font(.subheadline)
            .foregroundStyle(Color("TextColor"))
        }
        .padding(.horizontal, size10)
        .sheet(isPresented: $isSharing, onDismiss: {
            print("Dismissed")
        }) {
            if #available(iOS 16.0, *) {
                ActivityView(activityItems: [poemText()])
                    .presentationDetents([.medium])
            } else {
                // Fallback on earlier versions
                ActivityView(activityItems: [poemText()])
            }
        }
    }
    
    func poemText() -> String {
        var explanationsStr : String = ""
        
//        if let poem = poem {
            var expTitle = ""
            print(explanations.count)
            for explanation in explanations {
                if let title = explanation.title, title != "" {
                    expTitle = """
                    \(title):
                    
                    """
                }
                explanationsStr += """
                \(expTitle)\(explanation.meaning ?? "")
                
                
                """
            }

            return """
            \(poem.bookname ?? "")\(getCategoryDisplay())
            
            \(poem.book?.poemType ?? "பாடல் ") \(poem.number) :
            \(poem.poem ?? "")
            
            \(explanationsStr)
            """
//        }
        
//        return ""
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

