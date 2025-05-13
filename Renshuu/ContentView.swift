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

    var body: some View {
        NavigationStack {
            if onboardingNeeded {
                Welcome()
            } else {
                Main()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Renshuu.self, inMemory: true)
}
