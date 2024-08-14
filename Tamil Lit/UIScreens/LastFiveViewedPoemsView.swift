//
//  LastFiveViewedPoemsView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 14/08/24.
//

import SwiftUI

struct LastFiveViewedPoemsView: View {
    @Binding var viewedPoems: [Poem]
    
    var body: some View {
        VStack {
            //Results
            List {
                ForEach(viewedPoems, id: \.self) { poem in
                    VStack(alignment: .leading) {
                        if let title = poem.title, title != "" {
                            Text(title)
                                .font(.headline)
                        }
                        if let poemText = poem.poem {
                            Text(poemText)
                            
                        }
                    }
                    .onTapGesture {
//                        selectedPoem = poem
//                        isShowingDetail = true
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}
