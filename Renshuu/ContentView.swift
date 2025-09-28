//
//  ContentView.swift
//  Renshuu
//
//  Created by Roland Kajatin on 18/03/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @AppStorage("onboardingNeeded") var onboardingNeeded: Bool = true

    @State private var searchText: String = ""

    @ViewBuilder
    var body: some View {
        TabView {
            Tab("Catalogue", systemImage: "books.vertical") {
                RenshuuList()
            }

            Tab("Practise", systemImage: "pencil.and.outline") {
                RecallPractise()
            }

            Tab(role: .search) {
                RenshuuList(searchText: searchText)
            }
        }
        .searchable(text: $searchText)
        .sheet(
            isPresented: $onboardingNeeded,
            onDismiss: {
                onboardingNeeded = false
            }
        ) {
            Welcome()
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    var notificationsManager = NotificationsManager()
    ContentView()
        .modelContainer(for: Renshuu.self, inMemory: true)
        .environment(notificationsManager)
}
