//
//  Item.swift
//  Renshuu
//
//  Created by Roland Kajatin on 18/03/2025.
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
