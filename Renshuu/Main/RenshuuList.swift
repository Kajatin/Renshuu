//
//  RenshuuList.swift
//  Renshuu
//
//  Created by Roland Kajatin on 06/05/2025.
//

import SwiftData
import SwiftUI

struct RenshuuList: View {
    @Query(sort: \Renshuu.dueDate, order: .reverse) var renshuus: [Renshuu]

    @Binding var isSearchPresented: Bool

    @State private var searchText: String = ""

    var groupedRenshuus: [(key: Date, value: [Renshuu])] {
        let filtered =
            searchText.isEmpty
            ? renshuus
            : renshuus.filter {
                $0.original.localizedCaseInsensitiveContains(searchText) || $0.translation.localizedCaseInsensitiveContains(searchText)
            }

        return Dictionary(grouping: filtered) { renshuu in
            Calendar.current.startOfDay(for: renshuu.dueDate)
        }
        .sorted { $0.key < $1.key }
    }

    var body: some View {
        List {
            ForEach(groupedRenshuus, id: \.key) { date, items in
                Section(header: Text(date.formatted(date: .abbreviated, time: .omitted))) {
                    ForEach(items) { renshuu in
                        NavigationLink(destination: EditRenhsuu(renshuu: renshuu)) {
                            Text(renshuu.original)
                                .foregroundStyle(.neutral950)
                        }
                    }
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
        .navigationBarTitleDisplayMode(.automatic)
        .searchable(text: $searchText, isPresented: $isSearchPresented)
    }
}

#Preview {
    NavigationStack {
        RenshuuList(isSearchPresented: .constant(false))
    }
    .modelContainer(for: Renshuu.self, inMemory: true)
}
