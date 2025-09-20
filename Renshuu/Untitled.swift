//
//  Untitled.swift
//  Renshuu
//
//  Created by Roland Kajatin on 16/09/2025.
//
import Playgrounds
import FoundationModels

@available(iOS 26.0, *)
@Generable(description: "A learning card for a bilingual flashcard app between target-language and English.")
struct LLMCard {
    @Guide(description: "The target-language headword as typed by the user. Keep original casing/diacritics.")
    var headword: String

    @Guide(description: "Sense list with potentially multiple different meanings of the same headword.", .count(1...3))
    var senses: [Sense]

    @Guide(description: "A few natural example sentences in the target-language with aligned translations.", .count(2...4))
    var examples: [ExampleItem]

    @Guide(description: "Close-in-meaning items in target-language; keep short and distinct.", .count(0...4))
    var synonyms: [String]

    @Guide(description: "Opposites/contrasts; keep short and distinct.", .count(0...4))
    var antonyms: [String]
}

@available(iOS 26.0, *)
@Generable(description: "A compact sense entry describing one meaning of the headword for learners.")
struct Sense {
    @Guide(description: "Compact English gloss for this sense. 2–6 words.")
    var gloss: String

    @Guide(description: "2–3 sentence explanation in English. Mention position/grammar if relevant.")
    var explanation: String

    @Guide(description: "One actionable usage tip (max ~120 chars).")
    var usageTip: String
}

@available(iOS 26.0, *)
@Generable(description: "A paired example showing natural target-language usage with an aligned English translation. Keep sentences short and level-appropriate.")
struct ExampleItem {
    @Guide(description: "Target-language sentence. Natural, A2–B2 level. 5–12 words.")
    var text: String

    @Guide(description: "Aligned English translation, same meaning and tone.")
    var translation: String
}

#Playground {
    if #available(iOS 26.0, *) {
        let session = LanguageModelSession(instructions:"""
You are a careful lexicography assistant for a flashcard app. The base language is always English.
- Target language: Danish.
- Audience: language learners (A2–B2).
- Be precise, concise, and neutral.
- If meaning/usage is ambiguous, say so and give the most common sense.
- Prefer high-frequency, natural examples. Avoid slang unless requested.
- Never invent facts (e.g., false senses). If unknown, return "unknown".
""")
        
        let response = try await session.respond(to: "til gengæld", generating: LLMCard.self)
        print(response)
    } else {
        print("LanguageModelSession requires iOS 26.0 or newer. Skipping model call.")
    }
}

