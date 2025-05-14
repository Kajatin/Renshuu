//
//  Welcome.swift
//  Renshuu
//
//  Created by Roland Kajatin on 11/05/2025.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.appLowSaturation
                .ignoresSafeArea(.all, edges: .all)

            GeometryReader { geo in
                VStack(spacing: 40) {
                    Text("Welcome")
                        .foregroundStyle(Color.appHighSaturation)
                        .font(.system(size: 36, weight: .medium, design: .serif))
                        .padding(.top, 40)

                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            Group {
                                Text("Renshuu helps you learn new words and phrases.")
                                Text("It uses a simple algorithm to determine which words should be shown based on your progress.")
                                Text("You’ll rate how easily you recalled a word after seeing it. The better you are at recalling a word the less frequently Renshuu will show it to you.")
                            }
                            .foregroundStyle(.neutral950)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: geo.size.width * 0.8)
                        }
                    }

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Start by adding your first word or phrase.")
                            .foregroundStyle(Color.appHighSaturation)
                            .fontDesign(.serif)

                        NavigationLink(destination: CreateNewRenshuu(isOnboarding: true)) {
                            Text("Continue")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(CuteButtonStyle(hue: .appHue))
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        Welcome()
    }
    .modelContainer(for: Renshuu.self, inMemory: true)
}
