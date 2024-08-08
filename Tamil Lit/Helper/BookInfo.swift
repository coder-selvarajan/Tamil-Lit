//
//  BookInfo.swift
//  Tamil Lit
//
//  Created by Selvarajan on 21/07/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    var hexString: String {
        guard let components = cgColor?.components, components.count >= 3 else {
            return "#000000"
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        let a = Float(components.count >= 4 ? components[3] : 1.0)
        let hex = String(format: "%02lX%02lX%02lX%02lX", lroundf(a * 255), lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        return "#\(hex)"
    }
}

struct BookInfo: Identifiable, Codable, Hashable {
    var id: UUID
    var order: Int
    var title: String
    var bannerDisplay: String
    var subtitle: String
    var poemCount: Int
    var image: String
    var color: Color
    var bannerColor: String
    var selected: Bool

    enum CodingKeys: String, CodingKey {
        case id, order, title, bannerDisplay, subtitle, poemCount, image, bannerColor, selected
        case colorHex
    }

    init(id: UUID, order: Int, title: String, bannerDisplay: String, subtitle: String, poemCount: Int, image: String, color: Color, bannerColor: String, selected: Bool) {
        self.id = id
        self.order = order
        self.title = title
        self.bannerDisplay = bannerDisplay
        self.subtitle = subtitle
        self.poemCount = poemCount
        self.image = image
        self.color = color
        self.bannerColor = bannerColor
        self.selected = selected
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        order = try container.decode(Int.self, forKey: .order)
        title = try container.decode(String.self, forKey: .title)
        bannerDisplay = try container.decode(String.self, forKey: .bannerDisplay)
        subtitle = try container.decode(String.self, forKey: .subtitle)
        poemCount = try container.decode(Int.self, forKey: .poemCount)
        image = try container.decode(String.self, forKey: .image)
        bannerColor = try container.decode(String.self, forKey: .bannerColor)
        selected = try container.decode(Bool.self, forKey: .selected)
        let colorHex = try container.decode(String.self, forKey: .colorHex)
        color = Color(hex: colorHex)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(order, forKey: .order)
        try container.encode(title, forKey: .title)
        try container.encode(title, forKey: .bannerDisplay)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(poemCount, forKey: .poemCount)
        try container.encode(image, forKey: .image)
        try container.encode(bannerColor, forKey: .bannerColor)
        try container.encode(selected, forKey: .selected)
        try container.encode(color.hexString, forKey: .colorHex)
    }
}

//let _books = [
//    BookInfo(
//        id: UUID(),
//        order: 1,
//        title: "திருக்குறள்",
//        subtitle: "1330 குறள்கள்",
//        image: "Thiruvalluvar",
//        color: .blue,
//        bannerColor: "colorThirukural",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 2,
//        title: "ஆத்திசூடி",
//        subtitle: "109 வாக்கியங்கள்",
//        image: "Avvaiyar",
//        color: .cyan,
//        bannerColor: "colorAthichudi",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 3,
//        title: "நாலடியார்",
//        subtitle: "400 பாடல்கள்",
//        image: "Jainmonk",
//        color: .indigo,
//        bannerColor: "colorNaaladiyar",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 4,
//        title: "ஆசாரக் கோவை",
//        subtitle: "100 பாடல்கள்",
//        image: "Acharam",
//        color: .purple.opacity(0.7),
//        bannerColor: "colorAcharakovai",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 5,
//        title: "இனியவை நாற்பது",
//        subtitle: "40 பாடல்கள்",
//        image: "GoodHandGesture",
//        color: .red.opacity(0.6),
//        bannerColor: "colorIniyavaiNaarpathu",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 6,
//        title: "இன்னா நாற்பது",
//        subtitle: "40 பாடல்கள்",
//        image: "CrossHands",
//        color: .orange.opacity(0.7),
//        bannerColor: "colorInnaNaarpathu",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 7,
//        title: "நான்மணிக்கடிகை",
//        subtitle: "101 பாடல்கள்",
//        image: "Bharathanattiyam",
//        color: .brown,
//        bannerColor: "colorNaanmanikadikai",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 8,
//        title: "திரிகடுகம்",
//        subtitle: "102 பாடல்கள்",
//        image: "Thirikadugam",
//        color: .gray,
//        bannerColor: "colorThirikadukam",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 9,
//        title: "முதுமொழிக் காஞ்சி",
//        subtitle: "100 பழமொழிகள்",
//        image: "PalmleafManuscript",
//        color: .teal,
//        bannerColor: "colorMothumozhikanchi",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 10,
//        title: "பழமொழி நானூறு",
//        subtitle: "400 பழமொழிகள்",
//        image: "OldPalmleaf",
//        color: .green.opacity(0.7),
//        bannerColor: "colorPazhamozhiNaanuru",
//        selected: true
//    )
//]

//let _books = [
//    BookInfo(
//        id: UUID(),
//        order: 1,
//        title: "திருக்குறள்",
//        subtitle: "1330 குறள்கள்",
//        image: "Thiruvalluvar",
//        color: thirukuralColor,
//        bannerColor: "colorThirukural",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 2,
//        title: "ஆத்திசூடி",
//        subtitle: "109 வாக்கியங்கள்",
//        image: "Avvaiyar2",
//        color: athichudiColor,
//        bannerColor: "colorAthichudi",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 3,
//        title: "நாலடியார்",
//        subtitle: "400 பாடல்கள்",
//        image: "JainSanyasi",
//        color: naaladiyarColor,
//        bannerColor: "colorNaaladiyar",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 4,
//        title: "ஆசாரக் கோவை",
//        subtitle: "100 பாடல்கள்",
//        image: "Acharam",
//        color: acharakovaiColor,
//        bannerColor: "colorAcharakovai",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 5,
//        title: "இனியவை நாற்பது",
//        subtitle: "40 பாடல்கள்",
//        image: "GoodHandGesture",
//        color: iniyavaiNaarpathuColor,
//        bannerColor: "colorIniyavaiNaarpathu",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 6,
//        title: "இன்னா நாற்பது",
//        subtitle: "40 பாடல்கள்",
//        image: "CrossHands",
//        color: innaNaarpathuColor,
//        bannerColor: "colorInnaNaarpathu",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 7,
//        title: "நான்மணிக்கடிகை",
//        subtitle: "101 பாடல்கள்",
//        image: "Bharathanattiyam",
//        color: naanmanikadikaiColor,
//        bannerColor: "colorNaanmanikadikai",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 8,
//        title: "திரிகடுகம்",
//        subtitle: "102 பாடல்கள்",
//        image: "Thirikadugam",
//        color: thirikadukamColor,
//        bannerColor: "colorThirikadukam",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 9,
//        title: "முதுமொழிக் காஞ்சி",
//        subtitle: "100 பழமொழிகள்",
//        image: "PalmleafManuscript",
//        color: muthumozhikanchiColor,
//        bannerColor: "colorMothumozhikanchi",
//        selected: true
//    ),
//    BookInfo(
//        id: UUID(),
//        order: 10,
//        title: "பழமொழி நானூறு",
//        subtitle: "400 பழமொழிகள்",
//        image: "OldPalmleaf",
//        color: pazhamozhiNaanooruColor,
//        bannerColor: "colorPazhamozhiNaanuru",
//        selected: true
//    )
//]


// Helper function to chunk array into smaller arrays
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

