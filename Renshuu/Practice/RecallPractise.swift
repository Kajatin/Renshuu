//
//  RecallPractise.swift
//  Renshuu
//
//  Created by Roland Kajatin on 06/05/2025.
//

import SwiftData
import SwiftUI

struct RecallPractise: View {
    @AppStorage("reversedPracticeOrder") var reversedPracticeOrder: Bool = false
    @State private var toggleReversedOrder: Bool = false

    @Environment(\.modelContext) private var context

    @State private var score = 3.0
    @State private var showResult = false
    @State private var randomHue = Double.random(in: 0..<1)

    static var fetchDescriptor: FetchDescriptor<Renshuu> {
        let startOfToday = Calendar.current.startOfDay(for: .now)
        let endOfToday = Calendar.current.date(byAdding: .day, value: 1, to: startOfToday)!

        var descriptor = FetchDescriptor<Renshuu>(
            predicate: #Predicate {
                $0.dueDate < endOfToday
            },
            sortBy: [SortDescriptor(\.dueDate, order: .forward)]
        )
        descriptor.fetchLimit = 1

        return descriptor
    }

    @Query(RecallPractise.fetchDescriptor) private var renshuus: [Renshuu]

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(UIColor(hue: randomHue, saturation: 0.2, brightness: 1, alpha: 1))
                .ignoresSafeArea(.all, edges: .all)

            VStack {
                Spacer()

                if let renshuu = renshuus.first {
                    VStack(spacing: 32) {
                        Text(reversedPracticeOrder ? renshuu.translation : renshuu.original)
                            .foregroundStyle(Color(UIColor(hue: randomHue, saturation: 0.8, brightness: 0.3, alpha: 1)))
                            .font(.system(size: 32, weight: .medium, design: .serif))

                        if showResult {
                            Text(reversedPracticeOrder ? renshuu.original : renshuu.translation)
                                .foregroundStyle(Color(UIColor(hue: randomHue, saturation: 0.7, brightness: 0.4, alpha: 1)))
                                .font(.system(size: 32, weight: .light, design: .serif))
                        }
                    }

                    Spacer()

                    VStack(spacing: 18) {
                        if showResult {
                            GradeSlider(
                                color: Color(UIColor(hue: randomHue, saturation: 0.8, brightness: 0.3, alpha: 1)),
                                textColor: Color(UIColor(hue: randomHue, saturation: 0.2, brightness: 1, alpha: 1)),
                                value: $score)
                        }

                        Button {
                            if showResult {
                                withAnimation {
                                    renshuus.first?.update(score: Int(score))
                                    showResult = false
                                    score = 3
                                    randomHue = Double.random(in: 0..<1)
                                    try? context.save()

                                    if toggleReversedOrder {
                                        reversedPracticeOrder.toggle()
                                        toggleReversedOrder = false
                                    }
                                }
                            } else {
                                withAnimation {
                                    showResult = true
                                }
                            }
                        } label: {
                            Text(showResult ? "Submit" : "Check")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(CuteButtonStyle(hue: randomHue))
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                withAnimation {
                                    toggleReversedOrder.toggle()
                                }
                            } label: {
                                Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                            }
                            .foregroundStyle(toggleReversedOrder ? Color(UIColor(hue: randomHue, saturation: 0.7, brightness: 0.4, alpha: 1)) : .neutral950)
                            .fontWeight(toggleReversedOrder ? .medium : .regular)
                            .symbolEffect(toggleReversedOrder ? .rotate : .rotate.counterClockwise, options: .speed(2.5), value: toggleReversedOrder)
                        }
                    }
                } else {
                    VStack(spacing: 32) {
                        Text("All caught up")
                            .foregroundStyle(Color(UIColor(hue: randomHue, saturation: 0.8, brightness: 0.3, alpha: 1)))
                            .font(.system(size: 32, weight: .medium, design: .serif))

                        Text("Come back later to practice")
                            .foregroundStyle(Color(UIColor(hue: randomHue, saturation: 0.7, brightness: 0.4, alpha: 1)))
                            .font(.system(size: 26, weight: .light, design: .serif))
                    }

                    Spacer()

                    Color.clear
                        .frame(maxWidth: .infinity, maxHeight: 0)
                }
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        RecallPractise()
    }
    .modelContainer(for: Renshuu.self, inMemory: true)
}
