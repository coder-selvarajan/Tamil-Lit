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
    @State private var isSharing = false
    
    var body: some View {
        Button {
            isSharing = true
        } label: {
            HStack(spacing: 5) {
                Image(systemName: "paperplane")
                Text("பகிர்")
            }
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isButton)
            .accessibilityLabel(Text("பகிர் - \((poem.poem ?? "").prefix(25))"))
            .accessibilityIdentifier("பகிர் - \(poem.bookname ?? "") - \(poem.number)")
            .font(.subheadline)
            .foregroundStyle(Color("TextColor"))
        }
        .padding(.horizontal, size10)
        .sheet(isPresented: $isSharing, onDismiss: {
            print("Dismissed")
        }) {
            if #available(iOS 16.0, *) {
                ActivityView(activityItems: [PoemHelper.poemText(poem: poem, explanations: explanations)])
                    .presentationDetents([.medium])
            } else {
                // Fallback on earlier versions
                ActivityView(activityItems: [PoemHelper.poemText(poem: poem, explanations: explanations)])
            }
        }
    }
    
    
}

class PoemHelper {
    static func getCategoryDisplay(poem: Poem) -> String {
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
    
    static func poemText(poem: Poem, explanations: [Explanation]) -> String {
        var explanationsStr : String = ""
        var expTitle = ""
        var poemTitle: String {
            if poem.number == 0 {
                return ""
            }
            
            let poemType = poem.book?.poemType ?? "பாடல் "
            
            if let title = poem.title, title != "" {
                return poemType + ": \(poem.number) \n" + title + ":"
            }
            
            return poemType + " - \(poem.number):"
        }
        
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
            \(poem.bookname ?? "")\(getCategoryDisplay(poem: poem))
            
            \(poemTitle)
            \(poem.poem ?? "")
            
            \(explanationsStr)
            """
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

