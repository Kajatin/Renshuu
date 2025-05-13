//
//  CuteButtonStyle.swift
//  Renshuu
//
//  Created by Roland Kajatin on 07/05/2025.
//

import SwiftUI

struct CuteButtonStyle: ButtonStyle {
    var hue: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(14)
            .fontWeight(.medium)
            .background(Color(UIColor(hue: hue, saturation: 0.8, brightness: 0.3, alpha: 1)))
            .foregroundStyle(Color(UIColor(hue: hue, saturation: 0.05, brightness: 1, alpha: 1)))
            .clipShape(Capsule())
    }
}
