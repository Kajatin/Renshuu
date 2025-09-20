//
//  RenshuuApp.swift
//  Renshuu
//
//  Created by Roland Kajatin on 18/03/2025.
//

import SwiftData
import SwiftUI

@main
struct RenshuuApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema(versionedSchema: AppSchemaV2.self)
        let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: false, cloudKitDatabase: .automatic)

        do {
            return try ModelContainer(for: schema, migrationPlan: MigrationPlan.self, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var notificationsManager = NotificationsManager()

    var body: some Scene {
        WindowGroup {
            Navigation()
        }
        .environment(notificationsManager)
        .modelContainer(sharedModelContainer)
    }
}
