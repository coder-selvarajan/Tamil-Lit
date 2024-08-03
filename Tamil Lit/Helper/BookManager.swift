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

    init(theme: Theme) {
        self.books = BookManager.getBooks(for: theme)
    }

    static func getBooks(for theme: Theme) -> [BookInfo] {
        return [
            BookInfo(
                id: UUID(),
                order: 1,
                title: "திருக்குறள்",
                subtitle: "1330 குறள்கள்",
                image: "Thiruvalluvar",
                color: theme.thirukuralColor,
                bannerColor: "colorThirukural",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 2,
                title: "ஆத்திசூடி",
                subtitle: "109 வாக்கியங்கள்",
                image: "Avvaiyar2",
                color: theme.athichudiColor,
                bannerColor: "colorAthichudi",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 3,
                title: "நாலடியார்",
                subtitle: "400 பாடல்கள்",
                image: "JainSanyasi",
                color: theme.naaladiyarColor,
                bannerColor: "colorNaaladiyar",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 4,
                title: "ஆசாரக் கோவை",
                subtitle: "100 பாடல்கள்",
                image: "Acharam",
                color: theme.acharakovaiColor,
                bannerColor: "colorAcharakovai",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 5,
                title: "இனியவை நாற்பது",
                subtitle: "40 பாடல்கள்",
                image: "GoodHandGesture",
                color: theme.iniyavaiNaarpathuColor,
                bannerColor: "colorIniyavaiNaarpathu",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 6,
                title: "இன்னா நாற்பது",
                subtitle: "40 பாடல்கள்",
                image: "CrossHands",
                color: theme.innaNaarpathuColor,
                bannerColor: "colorInnaNaarpathu",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 7,
                title: "நான்மணிக்கடிகை",
                subtitle: "101 பாடல்கள்",
                image: "Bharathanattiyam",
                color: theme.naanmanikadikaiColor,
                bannerColor: "colorNaanmanikadikai",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 8,
                title: "திரிகடுகம்",
                subtitle: "102 பாடல்கள்",
                image: "Thirikadugam",
                color: theme.thirikadukamColor,
                bannerColor: "colorThirikadukam",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 9,
                title: "முதுமொழிக் காஞ்சி",
                subtitle: "100 பழமொழிகள்",
                image: "PalmleafManuscript",
                color: theme.muthumozhikanchiColor,
                bannerColor: "colorMothumozhikanchi",
                selected: true
            ),
            BookInfo(
                id: UUID(),
                order: 10,
                title: "பழமொழி நானூறு",
                subtitle: "400 பழமொழிகள்",
                image: "OldPalmleaf",
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
