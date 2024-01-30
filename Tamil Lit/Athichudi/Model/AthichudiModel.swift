//
//  AathicudiModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import Foundation

struct AthichudiData: Codable {
    let lord_compliment: LordCompliment
    let athichudi: [Athichudi]
}

struct LordCompliment: Codable {
    let line1, line2, meaning, paraphase: String
}

struct Athichudi : Identifiable, Codable {
    var id: Int { number }
    let number: Int
    let poem: String
    let meaning, paraphrase, translation: String?
}
