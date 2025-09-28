//
//  Item.swift
//  Renshuu
//
//  Created by Roland Kajatin on 18/03/2025.
//

import Foundation
import SwiftData

@Model
final class Renshuu: Identifiable {
    var id = UUID()

    var original: String = ""
    var translation: String = ""

    /// It determines how quickly the inter-repetition interval grows.
    var easinessFactor: Double = 2.5
    /// Length of time in days until this item needs to be shown again.
    var interval: Int = 1
    /// The number of consequtive times this item was guessed correctly.
    var repetitions: Int = 0
    /// Date to show this item again.
    var dueDate: Date = Date()
    
    /// AI generated explanation of the word with some examples.
    var explainer: Explainer?
    
    init () {
        self.original = ""
        self.translation = ""
    }

    init(original: String, translation: String) {
        self.original = original
        self.translation = translation
    }

    func update(score: Int) {
        let q = max(0, min(5, score))

        if q >= 3 {
            if repetitions == 0 {
                interval = 1
            } else if repetitions == 1 {
                interval = 6
            } else {
                interval = Int(Double(interval) * easinessFactor)
            }
            repetitions += 1
        } else {
            repetitions = 0
            interval = 1
        }

        // EF update
        easinessFactor += (0.1 - (5 - Double(q)) * (0.08 + (5 - Double(q)) * 0.02))
        if easinessFactor < 1.3 {
            easinessFactor = 1.3
        }

        dueDate = Calendar.current.date(byAdding: .day, value: interval, to: Date.now)!
    }
}
