//
//  BookManager.swift
//  Tamil Lit
//
//  Created by Selvarajan on 03/08/24.
//

import Foundation
import SwiftUI

class BookManager: ObservableObject {
    @Published var books: [BookInfo]

    init() {
        let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme") ?? ThemeSelection.primary.rawValue
        let selTheme = ThemeSelection(rawValue: savedTheme) ?? .primary
        let currentTheme = ThemeManager.getTheme(for: selTheme)
        
        self.books = BookManager.getBooks(for: currentTheme)
    }

    static func getBooks(for theme: Theme) -> [BookInfo] {
        return [
            BookInfo(
                id: UUID(),
                order: 1,
                title: "திருக்குறள்",
                bannerDisplay: "திருக்குறள்",
                subtitle: "1330 குறள்கள்",
                poemCount: 1330,
                image: "_Thiruvalluvar",
                color: theme.thirukuralColor,
                bannerColor: "colorThirukural",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 2,
                title: "ஆத்திசூடி",
                bannerDisplay: "ஆத்திசூடி",
                subtitle: "109 வாக்கியங்கள்",
                poemCount: 109,
                image: "_Avvaiyar",
                color: theme.athichudiColor,
                bannerColor: "colorAthichudi",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 3,
                title: "நாலடியார்",
                bannerDisplay: "நாலடியார்",
                subtitle: "400 பாடல்கள்",
                poemCount: 400,
                image: "_JainMonk",
                color: theme.naaladiyarColor,
                bannerColor: "colorNaaladiyar",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 4,
                title: "ஆசாரக் கோவை",
                bannerDisplay: "ஆசாரக் \nகோவை",
                subtitle: "100 பாடல்கள்",
                poemCount: 100,
                image: "_Acharakovai",
                color: theme.acharakovaiColor,
                bannerColor: "colorAcharakovai",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 5,
                title: "இனியவை நாற்பது",
                bannerDisplay: "இனியவை \nநாற்பது",
                subtitle: "40 பாடல்கள்",
                poemCount: 40,
                image: "_Iniyavai",
                color: theme.iniyavaiNaarpathuColor,
                bannerColor: "colorIniyavaiNaarpathu",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 6,
                title: "இன்னா நாற்பது",
                bannerDisplay: "இன்னா \nநாற்பது",
                subtitle: "40 பாடல்கள்",
                poemCount: 40,
                image: "_Inna",
                color: theme.innaNaarpathuColor,
                bannerColor: "colorInnaNaarpathu",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 7,
                title: "நான்மணிக்கடிகை",
                bannerDisplay: "நான்மணிக் \nகடிகை",
                subtitle: "101 பாடல்கள்",
                poemCount: 101,
                image: "_Naanmanikadikai2",
                color: theme.naanmanikadikaiColor,
                bannerColor: "colorNaanmanikadikai",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 8,
                title: "திரிகடுகம்",
                bannerDisplay: "திரிகடுகம்",
                subtitle: "102 பாடல்கள்",
                poemCount: 102,
                image: "_Thirikadukam2",
                color: theme.thirikadukamColor,
                bannerColor: "colorThirikadukam",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 9,
                title: "முதுமொழிக் காஞ்சி",
                bannerDisplay: "முதுமொழிக் \nகாஞ்சி",
                subtitle: "100 பழமொழிகள்",
                poemCount: 100,
                image: "_Muthumozhi",
                color: theme.muthumozhikanchiColor,
                bannerColor: "colorMothumozhikanchi",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 10,
                title: "பழமொழி நானூறு",
                bannerDisplay: "பழமொழி \nநானூறு",
                subtitle: "400 பழமொழிகள்",
                poemCount: 400,
                image: "_Pazhamozhi",
                color: theme.pazhamozhiNaanooruColor,
                bannerColor: "colorPazhamozhiNaanuru",
                selected: true
            )
        ]
    }

    func updateBooks(with theme: Theme) {
        self.books = BookManager.getBooks(for: theme)
    }
}
