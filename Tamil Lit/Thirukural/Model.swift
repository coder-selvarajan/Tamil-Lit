//
//  Model.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import Foundation

struct Kural: Identifiable, Codable {
    var id: Int { Number }
    let Number: Int
    let Line1, Line2, Translation: String
    let mv, sp, mk: String 
    let couplet, explanation, transliteration1, transliteration2: String
}

struct KuralData: Codable {
    let kural: [Kural]
}
