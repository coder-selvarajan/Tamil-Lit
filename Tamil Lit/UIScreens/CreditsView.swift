//
//  CreditsView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 31/07/24.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Credits")
                    .font(.title2) // Smaller title
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                Text("Some of the content in the TamilLit app is sourced from the following websites:")
                    .font(.body)
                    .padding(.bottom, 10)
                
                CreditLinkView(title: "Wikipedia (Tamil)", url: "https://ta.wikipedia.org")
                CreditLinkView(title: "Sangathamizh", url: "https://sangathamizh.com")

                Text("Thirukural & Athichudi JSONs are sourced from these GitHub repositories:")
                    .font(.body)
                    .padding(.top, 20)
                
                CreditLinkView(title: "Thirukkural JSON", url: "https://github.com/tk120404/thirukkural")
                CreditLinkView(title: "Aathichudi JSON", url: "https://github.com/tk120404/Aathichudi")
                
                Spacer()
            }
            .padding()
        }
//        .navigationTitle("Credits")
    }
}

struct CreditLinkView: View {
    let title: String
    let url: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            
            Link(url, destination: URL(string: url)!)
                .font(.subheadline)
                .foregroundColor(.blue)
        }
        .padding(.bottom, 10)
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
