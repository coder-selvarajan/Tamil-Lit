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
    var subtitle: String
    var image: String
    var color: Color
    var selected: Bool

    enum CodingKeys: String, CodingKey {
        case id, order, title, subtitle, image, selected
        case colorHex
    }

    init(id: UUID, order: Int, title: String, subtitle: String, image: String, color: Color, selected: Bool) {
        self.id = id
        self.order = order
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.color = color
        self.selected = selected
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        order = try container.decode(Int.self, forKey: .order)
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
        image = try container.decode(String.self, forKey: .image)
        selected = try container.decode(Bool.self, forKey: .selected)
        let colorHex = try container.decode(String.self, forKey: .colorHex)
        color = Color(hex: colorHex)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(order, forKey: .order)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(image, forKey: .image)
        try container.encode(selected, forKey: .selected)
        try container.encode(color.hexString, forKey: .colorHex)
    }
}

let _books = [
    BookInfo(id: UUID(), order: 1, title: "திருக்குறள்", subtitle: "1330 குறள்கள்", image: "Murugan", color: .blue, selected: true),
    BookInfo(id: UUID(), order: 2, title: "ஆத்திசூடி", subtitle: "109 வாக்கியங்கள்", image: "Avvaiyar3", color: .cyan, selected: true),
    BookInfo(id: UUID(), order: 3, title: "நாலடியார்", subtitle: "400 பாடல்கள்", image: "Jainmonk", color: .indigo, selected: true),
    
    BookInfo(id: UUID(), order: 4, title: "ஆசாரக் கோவை", subtitle: "100 பாடல்கள்", image: "Ramar", color: .purple.opacity(0.7), selected: true),
    BookInfo(id: UUID(), order: 5, title: "இனியவை நாற்பது", subtitle: "40 பாடல்கள்", image: "Balaji", color: .red.opacity(0.6), selected: true),
    BookInfo(id: UUID(), order: 6, title: "இன்னா நாற்பது", subtitle: "40 பாடல்கள்", image: "Karuppusamy", color: .orange.opacity(0.7), selected: true),
    BookInfo(id: UUID(), order: 7, title: "நான்மணிக்கடிகை", subtitle: "101 பாடல்கள்", image: "Meenakshi", color: .brown, selected: true),
    BookInfo(id: UUID(), order: 8, title: "திரிகடுகம்", subtitle: "102 பாடல்கள்", image: "Adiyogi", color: .gray, selected: true),
    BookInfo(id: UUID(), order: 9, title: "முதுமொழிக் காஞ்சி", subtitle: "100 பழமொழிகள்", image: "Murugan", color: .teal, selected: true),
    BookInfo(id: UUID(), order: 10, title: "பழமொழி நானூறு", subtitle: "400 பழமொழிகள்", image: "Balaji", color: .green.opacity(0.7), selected: true)
]

func getColorByBook(_ value: String) -> Color {
    if let bookColor = _books.filter({ $0.title == value }).first?.color {
        return bookColor
    }
    
    return .blue
}

// Helper function to chunk array into smaller arrays
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

