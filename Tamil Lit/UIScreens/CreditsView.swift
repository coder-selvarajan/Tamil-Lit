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
            VStack(alignment: .leading) {
                Text("Credits")
                    .font(.title2) // Smaller title
                    .fontWeight(.bold)
                    .padding(.bottom, size20)
                
                Text("Some of the content in the TamilLit app is sourced from the following websites:")
                    .font(.body)
                    .padding(.bottom, size20)
                
                CreditLinkView(title: "ta.wikipedia.org", url: "https://ta.wikipedia.org")
                CreditLinkView(title: "sangathamizh.com", url: "https://sangathamizh.com")
                CreditLinkView(title: "github.com/tk120404", url: "https://github.com/tk120404")
                
                Spacer()
            }
            .padding()
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("credits-view")
        .accessibilityLabel("Credits View")
        .navigationBarBackButtonHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
        .customFontScaling()
    }
}

struct CreditLinkView: View {
    let title: String
    let url: String
    
    var body: some View {
        Text(title)
            .font(.body.bold())
        
//        VStack(alignment: .leading, spacing: size10) {
//            Text(title)
//                .font(.body.bold())
//            
//            Link(url, destination: URL(string: url)!)
//                .font(.subheadline)
//                .foregroundColor(.blue)
//        }
//        .padding(.bottom, size10)
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
