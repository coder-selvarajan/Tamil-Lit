//
//  KuralListView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import SwiftUI

struct KuralListView: View {
    let kuralData: [Kural]

    var body: some View {
//        NavigationView {
            List(kuralData) { item in
                NavigationLink(destination: KuralDetailView(kural: item)) {
                    Text("\(item.Number): \(item.Line1)")
                }
            }
            .navigationBarTitle("Thirukural")
            .navigationBarTitleDisplayMode(.inline)
//        }
    }
}

//#Preview {
//    KuralListView(kuralData: [Kural])
//}
