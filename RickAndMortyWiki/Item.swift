//
//  Item.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
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
