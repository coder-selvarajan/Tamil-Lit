//
//  AathicudiListView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

struct AthichudiListView: View {
    let athichudiData: [Athichudi]

    var body: some View {
        List(athichudiData) { item in
            NavigationLink(destination: AthichudiDetailView(athichudi: item)) {
                Text("\(item.number): \(item.poem)")
            }
        }
        .navigationBarTitle("ஆத்தி சூடி")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    AthichudiListView()
//}
