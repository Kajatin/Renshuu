//
//  RenshuuApp.swift
//  Renshuu
//
//  Created by Roland Kajatin on 18/03/2025.
//

import SwiftUI
import SwiftData

@main
struct RenshuuApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Renshuu.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, cloudKitDatabase: .automatic)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var notificationsManager = NotificationsManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(notificationsManager)
        .modelContainer(sharedModelContainer)
    }
}
