//
//  ListBackgroundModifier.swift
//  Tamil Lit
//
//  Created by Selvarajan on 04/08/24.
//

import SwiftUI

struct ListBackgroundModifier: ViewModifier {

    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
        } else {
            content
        }
    }
}

struct ListScrollIndicatorsModifier: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollIndicators(.hidden)
        } else {
            content
        }
    }
}
