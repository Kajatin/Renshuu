//
//  RenshuuExplainer.swift
//  Renshuu
//
//  Created by Roland Kajatin on 20/09/2025.
//

import FoundationModels
import SwiftUI

struct RenshuuExplainer: View {
    @AppStorage("targetLanguage") var targetLanguage: String = "Danish"
    
    var renshuu: Renshuu

    var model = SystemLanguageModel.default

    private var instructionText: String {
        """
        You are a careful lexicography assistant for a flashcard app. The base language is always English.
        - Target language: \(targetLanguage).
        - Audience: language learners (A2-B2).
        - Be precise, concise, and neutral.
        - If meaning/usage is ambiguous, say so and give the most common sense.
        - Prefer high-frequency, natural examples. Avoid slang unless requested.
        - Never invent facts (e.g., false senses). If unknown, return "unknown".
        """
    }

    @State private var session = LanguageModelSession(instructions: "")

    var body: some View {
        if let explainer = renshuu.explainer {
            Section {
                ForEach(explainer.senses, id: \.gloss) { sense in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(sense.gloss)

                        Text(sense.explanation)
                            .foregroundStyle(.secondary)
                    }
                }
            } header: {
                HStack {
                    Text("Senses")
                    Spacer()
                    Image(systemName: "wand.and.sparkles")
                        .foregroundStyle(LinearGradient(colors: [.blue, .pink], startPoint: .leading, endPoint: .trailing))
                }
            }

            Section {
                ForEach(explainer.examples, id: \.text) { example in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(example.text)

                        Text(example.translation)
                            .foregroundStyle(.secondary)
                    }
                }
            } header: {
                HStack {
                    Text("Examples")
                    Spacer()
                    Image(systemName: "wand.and.sparkles")
                        .foregroundStyle(LinearGradient(colors: [.blue, .pink], startPoint: .leading, endPoint: .trailing))
                }
            }

            Section {
                Button(role: .destructive) {
                    renshuu.explainer = nil
                } label: {
                    Text("Reset Explanation")
                }
            }
        } else {
            switch model.availability {
            case .available:
                Section {
                    Button {
                        if session.isResponding { return }

                        Task {
                            session = LanguageModelSession(instructions: instructionText)
                            let response = try await session.respond(to: renshuu.original, generating: Explainer.self)

                            renshuu.explainer = response.content
                        }
                    } label: {
                        if session.isResponding {
                            Text("Generating...")
                        } else {
                            Text("Generate Explanation")
                        }
                    }
                    .foregroundStyle(LinearGradient(colors: [.blue, .pink], startPoint: .leading, endPoint: .trailing))
                    .disabled(session.isResponding)
                } header: {
                    HStack {
                        Text("Explanation")
                        Spacer()
                        Image(systemName: "wand.and.sparkles")
                            .foregroundStyle(LinearGradient(colors: [.blue, .pink], startPoint: .leading, endPoint: .trailing))
                    }
                }
            case .unavailable(.appleIntelligenceNotEnabled):
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Apple Intelligence Disabled")
                            .foregroundStyle(.secondary)

                        Text("Enable it in Settings to get access to AI generated explanations and examples.")
                    }
                } header: {
                    HStack {
                        Text("Explanation")
                        Spacer()
                        Image(systemName: "wand.and.sparkles")
                            .foregroundStyle(LinearGradient(colors: [.blue, .pink], startPoint: .leading, endPoint: .trailing))
                    }
                }
            case .unavailable(.modelNotReady):
                Section {
                    Text("Please wait while Apple Intelligence is getting ready.")
                        .foregroundStyle(.secondary)
                } header: {
                    HStack {
                        Text("Explanation")
                        Spacer()
                        Image(systemName: "wand.and.sparkles")
                            .foregroundStyle(LinearGradient(colors: [.blue, .pink], startPoint: .leading, endPoint: .trailing))
                    }
                }
            default:
                EmptyView()
            }
        }
    }
}

private struct PreviewContainer: View {
    @State private var renshuu = Renshuu(original: "til gengæld", translation: "on the other hand")

    var body: some View {
        NavigationStack {
            EditRenhsuu(renshuu: renshuu)
        }
        .modelContainer(for: Renshuu.self, inMemory: true)
    }
}

#Preview {
    PreviewContainer()
}
