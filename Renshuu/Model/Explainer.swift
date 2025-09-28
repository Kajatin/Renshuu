//
//  Explainer.swift
//  Renshuu
//
//  Created by Roland Kajatin on 20/09/2025.
//

import Foundation
import FoundationModels

@Generable(description: "A learning card for a bilingual flashcard app between target-language and English.")
struct Explainer: Codable {
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

@Generable(description: "A compact sense entry describing one meaning of the headword for learners.")
struct Sense: Codable {
    @Guide(description: "Compact English gloss for this sense. 2–6 words.")
    var gloss: String

    @Guide(description: "2–3 sentence explanation in English. Mention position/grammar if relevant.")
    var explanation: String

    @Guide(description: "One actionable usage tip (max ~120 chars).")
    var usageTip: String
}

@Generable(description: "A paired example showing natural target-language usage with an aligned English translation. Keep sentences short and level-appropriate.")
struct ExampleItem: Codable {
    @Guide(description: "Target-language sentence. Natural, A2–B2 level. 5–12 words.")
    var text: String

    @Guide(description: "Aligned English translation, same meaning and tone.")
    var translation: String
}
