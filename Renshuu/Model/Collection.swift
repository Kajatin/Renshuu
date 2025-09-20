//
//  Collection.swift
//  Renshuu
//
//  Created by Roland Kajatin on 04/09/2025.
//

import Foundation
import SwiftData

@Model
class CollectionV1: Hashable {
    var id = UUID()

    var title: String = ""
    var icon: String = "archivebox.fill"
    var createdOn: Date = Date.now
    @Relationship(deleteRule: .cascade)
    var items: [Renshuu]? = []

    init(title: String, icon: String? = nil) {
        self.title = title
        if let icon = icon {
            self.icon = icon
        }
    }
}
