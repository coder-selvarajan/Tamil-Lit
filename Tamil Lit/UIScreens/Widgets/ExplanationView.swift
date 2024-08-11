//
//  ExplanationView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 11/08/24.
//

import SwiftUI

struct ExplanationView: View {
    let explanations: [Explanation]
    
    var body: some View {
        ForEach(explanations, id:\.self) { explanation in
            VStack(alignment: .leading, spacing: 2.0) {
                if let title = explanation.title, title != "" {
                    Text("\(title): ")
                        .textSelection(.enabled)
                        .font(.body.bold())
                        .padding(.bottom, 5)
                }
                Text("\(explanation.meaning ?? "")")
                    .textSelection(.enabled)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                if explanations.last != explanation {
                    Divider()
                        .background(.gray)
                        .padding(.vertical)
                }
            }
        }
    }
}
