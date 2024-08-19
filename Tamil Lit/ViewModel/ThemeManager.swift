//
//  ThemeManager.swift
//  Tamil Lit
//
//  Created by Selvarajan on 03/08/24.
//

import SwiftUI

// Color themes
struct Theme: Equatable {
    let thirukuralColor: Color
    let athichudiColor: Color
    let naaladiyarColor: Color
    let acharakovaiColor: Color
    let iniyavaiNaarpathuColor: Color
    let innaNaarpathuColor: Color
    let naanmanikadikaiColor: Color
    let thirikadukamColor: Color
    let muthumozhikanchiColor: Color
    let pazhamozhiNaanooruColor: Color

    static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.thirukuralColor == rhs.thirukuralColor &&
               lhs.athichudiColor == rhs.athichudiColor &&
               lhs.naaladiyarColor == rhs.naaladiyarColor &&
               lhs.acharakovaiColor == rhs.acharakovaiColor &&
               lhs.iniyavaiNaarpathuColor == rhs.iniyavaiNaarpathuColor &&
               lhs.innaNaarpathuColor == rhs.innaNaarpathuColor &&
               lhs.naanmanikadikaiColor == rhs.naanmanikadikaiColor &&
               lhs.thirikadukamColor == rhs.thirikadukamColor &&
               lhs.muthumozhikanchiColor == rhs.muthumozhikanchiColor &&
               lhs.pazhamozhiNaanooruColor == rhs.pazhamozhiNaanooruColor
    }
}

struct Themes {
    static let colorfulTheme = Theme(thirukuralColor: Color.blue.opacity(0.85),
                                    athichudiColor: Color.cyan.opacity(0.9),
                                    naaladiyarColor: Color.indigo.opacity(0.85),
                                    acharakovaiColor: Color.purple.opacity(0.5),
                                    iniyavaiNaarpathuColor: Color.red.opacity(0.4),
                                    innaNaarpathuColor: Color.orange.opacity(0.5),
                                    naanmanikadikaiColor: Color.brown.opacity(0.9),
                                    thirikadukamColor: Color.gray.opacity(0.9),
                                    muthumozhikanchiColor: Color.teal.opacity(0.85),
                                    pazhamozhiNaanooruColor: Color.green.opacity(0.45))
    
    static let lightTheme = Theme(thirukuralColor: Color.gray,
                                    athichudiColor: Color.gray,
                                    naaladiyarColor: Color.gray,
                                    acharakovaiColor: Color.gray,
                                    iniyavaiNaarpathuColor: Color.gray,
                                    innaNaarpathuColor: Color.gray,
                                    naanmanikadikaiColor: Color.gray,
                                    thirikadukamColor: Color.gray,
                                    muthumozhikanchiColor: Color.gray,
                                    pazhamozhiNaanooruColor: Color.gray)
    
    static let darkTheme = Theme(thirukuralColor: Color.gray,
                                 athichudiColor: Color.gray,
                                 naaladiyarColor: Color.gray,
                                 acharakovaiColor: Color.gray,
                                 iniyavaiNaarpathuColor: Color.gray,
                                 innaNaarpathuColor: Color.gray,
                                 naanmanikadikaiColor: Color.gray,
                                 thirikadukamColor: Color.gray,
                                 muthumozhikanchiColor: Color.gray,
                                 pazhamozhiNaanooruColor: Color.gray)
}

enum ThemeSelection: String {
    case colorful, light, dark
}

class ThemeManager: ObservableObject {
    @Published var currentTheme: Theme //= ThemeManager.getTheme(for: .light)
    @Published var selectedTheme: ThemeSelection //= .light

    init() {
        let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme") ?? ThemeSelection.light.rawValue
        let selTheme = ThemeSelection(rawValue: savedTheme) ?? .light
        self.selectedTheme = selTheme
        self.currentTheme = ThemeManager.getTheme(for: selTheme)
    }
    
    static func getTheme(for selection: ThemeSelection) -> Theme {
        switch selection {
        case .colorful:
            return Themes.colorfulTheme
        case .light:
            return Themes.lightTheme
        case .dark:
            return Themes.darkTheme
        }
    }

    func setTheme(_ selection: ThemeSelection) {
        UserDefaults.standard.setValue(selection.rawValue, forKey: "selectedTheme")
        self.selectedTheme = selection
        self.currentTheme = ThemeManager.getTheme(for: selection)
    }
}

