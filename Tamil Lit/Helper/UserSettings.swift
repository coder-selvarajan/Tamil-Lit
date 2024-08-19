//
//  UserSettings.swift
//  Tamil Lit
//
//  Created by Selvarajan on 27/07/24.
//

import SwiftUI
import Combine

class UserSettings: ObservableObject {
    @AppStorage("darkMode") var darkMode: Bool = false
    @AppStorage("notificationsEnabled") var notificationsEnabled: Bool = false
    @AppStorage("fontScaling") var fontScaling: FontScalingOption = .normal
}

enum FontScalingOption: String, CaseIterable, Identifiable {
    case small, normal, large, extraLarge

    var id: String { self.rawValue }

    var sizeCategory: ContentSizeCategory {
        switch self {
        case .small:
            return .medium
        case .normal:
            return .large
        case .large:
            return .extraLarge
        case .extraLarge:
            return .extraExtraLarge
        }
    }
}
