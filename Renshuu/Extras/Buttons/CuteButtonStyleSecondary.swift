//
//  CuteButtonStyleSecondary.swift
//  Renshuu
//
//  Created by Roland Kajatin on 07/05/2025.
//

import SwiftUI

struct CuteButtonStyleSecondary: ButtonStyle {
    var hue: Double

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(14)
            .fontWeight(.medium)
            .foregroundStyle(
                Color(
                    UIColor(
                        hue: hue, saturation: 0.8, brightness: 0.3, alpha: 1))
            )
            .clipShape(Capsule())
    }
}
