//
//  RenshuuList.swift
//  Renshuu
//
//  Created by Roland Kajatin on 06/05/2025.
//

import SwiftData
import SwiftUI

struct RenshuuList: View {
    @Query(sort: \Renshuu.dueDate, order: .forward) var renshuus: [Renshuu]

    var body: some View {
        List {
            ForEach(renshuus) { renshuu in
                NavigationLink(destination: EditRenhsuu(renshuu: renshuu)) {
                    Text(renshuu.original)
                        .foregroundStyle(.neutral950)
                }
            }

            // Empty footer to allow extra space
            Section(footer: Spacer().frame(height: 140)) {
                EmptyView()
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle("Collection")
    }
}

#Preview {
    RenshuuList()
        .modelContainer(for: Renshuu.self, inMemory: true)
}
