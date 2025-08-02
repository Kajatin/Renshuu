//
//  RenshuuList.swift
//  Renshuu
//
//  Created by Roland Kajatin on 06/05/2025.
//

import SwiftData
import SwiftUI

struct RenshuuList: View {
    var searchText: String = ""
    
    @Query(sort: \Renshuu.dueDate, order: .reverse) var renshuus: [Renshuu]

    private var groupedRenshuus: [(key: Date, value: [Renshuu])] {
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
        NavigationStack {
            List {
                ForEach(groupedRenshuus, id: \.key) { date, items in
                    Section(header: Text(date.formatted(date: .abbreviated, time: .omitted))) {
                        ForEach(items) { renshuu in
                            NavigationLink(destination: EditRenhsuu(renshuu: renshuu)) {
                                Text(renshuu.original)
                            }
                        }
                    }
                }
            }
            .overlay {
                if groupedRenshuus.isEmpty {
                    if searchText.isEmpty {
                        ContentUnavailableView {
                            Label("No Words Yet", systemImage: "book.closed.fill")
                        } description: {
                            Text("Words you add will appear here")
                        } actions: {
                            NavigationLink(destination: CreateNewRenshuu()) {
                                Text("Add Your First Word")
                                    .padding(10)
                                    .font(.headline)
                            }
                            .buttonStyle(.bordered)
                            .tint(.accentColor)
                        }
                    } else {
                        ContentUnavailableView {
                            Label("No Matching Words", systemImage: "magnifyingglass")
                        } description: {
                            Text("Try searching for a different word")
                        }
                    }
                }
            }
            .navigationTitle("Catalogue")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: Settings()) {
                        Image(systemName: "gear")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: CreateNewRenshuu()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    RenshuuList()
        .modelContainer(for: Renshuu.self, inMemory: true)
}
