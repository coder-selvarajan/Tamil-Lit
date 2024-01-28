//
//  Item.swift
//  Tamil Lit
//
//  Created by Selvarajan on 28/01/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
