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
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("Collection")
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(.neutral800)
                    .opacity(0.7)

                if renshuus.isEmpty {
                    HStack {
                        Text("Start by adding a new Renshuu")
                            .foregroundStyle(.neutral950)

                        Spacer()
                    }
                    .padding(.top)
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(Array(renshuus.enumerated()), id: \.element.id) { index, renshuu in
                                VStack(alignment: .leading, spacing: 0) {
                                    NavigationLink(destination: EditRenhsuu(renshuu: renshuu)) {
                                        HStack {
                                            RenshuuListRowItem(renshuu: renshuu)

                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 14))
                                                .foregroundStyle(.neutral800)
                                                .opacity(0.8)
                                        }
                                    }
                                    .padding(.vertical)

                                    if index < renshuus.count - 1 {
                                        Divider()
                                    }
                                }
                            }

                            Spacer()
                                .frame(height: 140)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .padding(.top)
        }
        .scenePadding(.horizontal)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    RenshuuList()
        .modelContainer(for: Renshuu.self, inMemory: true)
}
