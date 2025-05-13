//
//  CuteButtonStyleLight.swift
//  Renshuu
//
//  Created by Roland Kajatin on 08/05/2025.
//

import SwiftUI

struct CuteButtonStyleLight: ButtonStyle {
    var hue: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(14)
            .fontWeight(.medium)
            .foregroundStyle(Color(UIColor(hue: hue, saturation: 0.8, brightness: 0.3, alpha: 1)))
            .overlay(
                Capsule()
                    .stroke(Color(UIColor(hue: hue, saturation: 0.8, brightness: 0.3, alpha: 1)), lineWidth: 2)
            )
            .clipShape(Capsule())
    }
}
