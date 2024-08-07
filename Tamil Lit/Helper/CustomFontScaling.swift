//
//  CustomFontScaling.swift
//  Tamil Lit
//
//  Created by Selvarajan on 06/08/24.
//

import SwiftUI

private struct CustomFontScalingKey: EnvironmentKey {
    static let defaultValue: ContentSizeCategory = .large
}

extension EnvironmentValues {
    var customFontScaling: ContentSizeCategory {
        get { self[CustomFontScalingKey.self] }
        set { self[CustomFontScalingKey.self] = newValue }
    }
}



//struct CustomFontScalingModifier: ViewModifier {
//    @Environment(\.customFontScaling) var customFontScaling
//
//    func body(content: Content) -> some View {
//        content.environment(\.sizeCategory, .extraExtraLarge) // Example for scaling up
//    }
//}

struct CustomFontScalingModifier: ViewModifier {
    @Environment(\.customFontScaling) var customFontScaling

    func body(content: Content) -> some View {
        content.environment(\.sizeCategory, customFontScaling)
    }
}

extension View {
    func customFontScaling() -> some View {
        self.modifier(CustomFontScalingModifier())
    }
}

