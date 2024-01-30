//
//  KuralCategoryModel.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/01/24.
//
import SwiftUI
import Foundation


struct KuralCategoryData: Codable {
    var tamil: String
    var section: KuralSectionData
    var repo: String
}

// Paal
struct KuralSectionData: Codable {
    var tamil: String
    var detail: [KuralSection]
}

struct KuralSection: Identifiable, Codable, Hashable {
    var id: Int { number }
    var name: String
    var transliteration: String
    var translation: String
    var number: Int
    var chapterGroup: KuralChapterGroupData
}

// Iyal
struct KuralChapterGroupData: Codable, Hashable {
    var tamil: String
    var detail: [KuralChapterGroup]
}

struct KuralChapterGroup: Codable, Identifiable, Hashable {
    var id: Int { number }
    var name: String
    var translation: String
    var transliteration: String
    var number: Int
    var chapters: KuralChapterData
}

// Athigaram
struct KuralChapterData: Codable, Hashable {
    var tamil: String
    var detail: [KuralChapter]
}

struct KuralChapter: Codable, Identifiable, Hashable {
    var id: Int { number }
    var name: String
    var translation: String
    var transliteration: String
    var number: Int
    var start: Int
    var end: Int
}
