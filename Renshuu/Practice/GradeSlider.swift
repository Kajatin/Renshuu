//
//  GradeSlider.swift
//  Renshuu
//
//  Created by Roland Kajatin on 06/05/2025.
//

import SwiftUI

struct GradeSlider: View {
    var color: Color
    var textColor: Color
    var withHaptics: Bool = true
    @Binding var value: Double

    let labels = [
        ("Failed to recall", "Total blackout"),
        ("Incorrect response", "Felt familiar"),
        ("Incorrect response", "Seemed easy to remember"),
        ("Correct response", "Significant effort to recall"),
        ("Correct response", "Some hesitation"),
        ("Correct response", "Perfect recall"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(labels[Int(value)].0)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(color)
                
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 4, height: 4)
                    .foregroundStyle(color)

                Text(labels[Int(value)].1)
                    .font(.caption)
                    .foregroundStyle(color)
            }
            
            CustomSlider(
                value: $value, in_: 0...5, color: color, textColor: textColor,
                withHaptics: withHaptics)
        }
    }
}

struct CustomSlider: View {
    @Binding var value: Double
    var in_: ClosedRange<Double>
    var step: Double = 1
    var color: Color = .gray
    var textColor: Color = .white
    var withHaptics: Bool

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Track
                Capsule()
                    .fill(color.opacity(0.25))
                    .frame(width: geometry.size.width, height: 28)

                // Tinted track
                ZStack {
                    Capsule()
                        .fill(color.opacity(0.7))
                        .frame(
                            width: CGFloat(value + 1)
                                * (geometry.size.width
                                    / (CGFloat(in_.upperBound) + 2)),
                            height: 28
                        )
                        .offset(x: 0)
                }

                // Tick marks
                ForEach(
                    0...Int(in_.upperBound) - Int(in_.lowerBound), id: \.self
                ) { i in
                    let x =
                        CGFloat(i + 1)
                        * (geometry.size.width / (CGFloat(in_.upperBound) + 2))
                    Text("\(i)")
                        .offset(x: x - 6)
                        .font(
                            .custom(
                                "Kanit-Regular", size: 14, relativeTo: .caption)
                        )
                        .foregroundStyle(textColor)
                        .opacity(0.25)
                }

                // Thumb
                Text("\(Int(value))")
                    .frame(width: 40, height: 32, alignment: .center)
                    .background(color, in: Capsule())
                    .foregroundStyle(textColor)
                    .offset(
                        x: CGFloat(value + 1)
                            * (geometry.size.width
                               / (CGFloat(in_.upperBound) + 2)) - 22
                    )
                    .shadow(radius: 4)
                    .gesture(
                        DragGesture(
                            minimumDistance: geometry.size.width
                                / CGFloat(in_.upperBound)
                        )
                        .onChanged({ value in
                            let newValue =
                                ((Double(value.location.x) + 22)
                                    / (geometry.size.width
                                        / (CGFloat(in_.upperBound) + 2)) - 1)
                            let roundedValue = round(newValue / step) * step
                            let clippedValue = min(
                                max(roundedValue, in_.lowerBound),
                                in_.upperBound)
                            if self.value != clippedValue && withHaptics {
                                HapticsManager.shared.playHaptics(
                                    intensity: 0.4, sharpness: 0.8)
                            }
                            self.value = clippedValue
                        })
                    )
            }
        }
        .frame(height: 40)
    }
}

#Preview {
    let randomHue: Double = 0.3
    return VStack(spacing: 24) {
        GradeSlider(
            color: Color.appHighSaturation,
            textColor: Color.appLowSaturation,
            value: .constant(0))
        GradeSlider(
            color: Color.appHighSaturation,
            textColor: Color.appLowSaturation,
            value: .constant(1))
        GradeSlider(
            color: Color.appHighSaturation,
            textColor: Color.appLowSaturation,
            value: .constant(2))
        GradeSlider(
            color: Color.appHighSaturation,
            textColor: Color.appLowSaturation,
            value: .constant(3))
        GradeSlider(
            color: Color.appHighSaturation,
            textColor: Color.appLowSaturation,
            value: .constant(4))
        GradeSlider(
            color: Color.appHighSaturation,
            textColor: Color.appLowSaturation,
            value: .constant(5))
    }
    .scenePadding()
}
