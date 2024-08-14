//
//  LastFiveViewedPoemsView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 14/08/24.
//

import SwiftUI

struct LastFiveViewedPoemsView: View {
    @StateObject private var vm = LastViewedPoemsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recently Viewed: ")
                .font(.title3.bold())
            
            //Results
            List {
                ForEach(vm.lastFiveViewedPoems, id: \.id) { poem in
                    VStack(alignment: .leading) {
                        Text("\(String(describing: poem.bookname)) - \(poem.number)")
                        
//                        if let title = poem.title, title != "" {
//                            Text(title)
//                                .font(.headline)
//                        }
                        if let poemText = poem.poem {
                            Text(poemText)
                                .lineLimit(3)
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
        .onAppear() {
            vm.getLastFiveViewedPoems()
        }
    }
}
