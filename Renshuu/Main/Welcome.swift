//
//  Welcome.swift
//  Renshuu
//
//  Created by Roland Kajatin on 11/05/2025.
//

import SwiftUI

struct Welcome: View {
    @AppStorage("onboardingNeeded") var onboardingNeeded: Bool = true

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("Welcome")
                .font(.largeTitle.bold())
                .padding(.vertical)
                .foregroundStyle(.accent.gradient)

            VStack(spacing: 16) {
                Text("Renshuu supports your journey to learn new words and phrases.")

                Text("It uses a smart, adaptive system to prioritize words that need more practice based on your progress.")

                Text("After reviewing a word, you’ll rate how easily you remembered it. The better your recall, the less often you’ll see that word again.")
            }
            .padding(.horizontal)
            .multilineTextAlignment(.center)

            Spacer()

            Button {
                withAnimation {
                    onboardingNeeded = false
                }
            } label: {
                Text("Get Started")
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .font(.headline)
            }
            .buttonStyle(.bordered)
            .tint(.accentColor)
        }
        .scenePadding()
    }
}

#Preview {
    NavigationStack {
        Welcome()
    }
    .modelContainer(for: Renshuu.self, inMemory: true)
}
