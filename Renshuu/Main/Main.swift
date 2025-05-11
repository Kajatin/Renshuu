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
    
    var body: some View {
        ZStack {
            Color.neutral50
                .ignoresSafeArea()

            NavigationStack {
                ZStack(alignment: .bottomTrailing) {
                    VStack(alignment: .leading, spacing: 0) {
//                        if !renshuus.isEmpty {
//                            WordOfTheDay()
//                        }

                        RenshuuList()
                    }

                    VStack {
                        if !renshuus.isEmpty {
                            NavigationLink(destination: RecallPractise()) {
                                Image(systemName: "play.fill")
                                    .frame(width: 24, height: 24)
                            }
                            .buttonStyle(CuteButtonStyle(hue: 0.48))
                        }

                        NavigationLink(destination: CreateNewRenshuu()) {
                            Image(systemName: "plus")
                                .frame(width: 24, height: 24)
                        }
                        .buttonStyle(CuteButtonStyle(hue: 0.48))
                    }
                    .scenePadding()
                }
            }
        }
    }
}

#Preview {
    Main()
        .modelContainer(for: Renshuu.self, inMemory: true)
}
