//
//  Migrations.swift
//  Renshuu
//
//  Created by Roland Kajatin on 04/09/2025.
//

import Foundation
import SwiftData

enum AppSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] {
        [RenshuuV1.self]
    }
}

enum AppSchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2, 0, 0)

    static var models: [any PersistentModel.Type] {
        [CollectionV1.self, RenshuuV2.self]
    }
}

typealias Collection = CollectionV1
typealias Renshuu = RenshuuV2

enum MigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] = [AppSchemaV1.self, AppSchemaV2.self]
    static var stages: [MigrationStage] = [
        migrateV1toV2
    ]

    static let migrateV1toV2 = MigrationStage.custom(
        fromVersion: AppSchemaV1.self,
        toVersion: AppSchemaV2.self,
        willMigrate: { context in
            // Create default collection once
            let defaultCollection = CollectionV1(title: "Default")
            context.insert(defaultCollection)

            // Fetch all v1 items
            let v1Items = try context.fetch(FetchDescriptor<RenshuuV1>())

            for old in v1Items {
                let newItem = RenshuuV2(
                    original: old.original,
                    translation: old.translation,
                    collection: defaultCollection
                )

                newItem.easinessFactor = old.easinessFactor
                newItem.interval = old.interval
                newItem.repetitions = old.repetitions
                newItem.dueDate = old.dueDate

                context.insert(newItem)
            }

            try context.save()
        },
        didMigrate: nil
    )
}
