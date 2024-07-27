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
}
