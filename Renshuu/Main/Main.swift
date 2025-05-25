//
//  Main.swift
//  Renshuu
//
//  Created by Roland Kajatin on 11/05/2025.
//

import SwiftData
import SwiftUI

struct Main: View {
    @Query var renshuus: [Renshuu]

    @Environment(\.modelContext) private var modelContext

    @State private var showSearch: Bool = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                //                if !renshuus.isEmpty {
                //                    WordOfTheDay()
                //                }

                RenshuuList(isSearchPresented: $showSearch)
            }

            VStack {
                if !renshuus.isEmpty {
                    NavigationLink(destination: RecallPractise()) {
                        Image(systemName: "play.fill")
                            .frame(width: 24, height: 24)
                    }
                    .buttonStyle(CuteButtonStyle(hue: .appHue))
                }

                NavigationLink(destination: CreateNewRenshuu()) {
                    Image(systemName: "plus")
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(CuteButtonStyle(hue: .appHue))
            }
            .scenePadding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showSearch.toggle()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.neutral950)
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: Settings()) {
                    Image(systemName: "switch.2")
                        .foregroundStyle(.neutral950)
                }
            }
        }
    }
}

#Preview {
    var notificationsManager = NotificationsManager()
    NavigationStack {
        Main()
    }
    .modelContainer(for: Renshuu.self, inMemory: true)
    .environment(notificationsManager)
}
