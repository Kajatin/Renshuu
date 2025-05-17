//
//  LowKeyButtonStyle.swift
//  Renshuu
//
//  Created by Roland Kajatin on 15/05/2025.
//

import SwiftUI

struct LowKeyButtonStyle: ButtonStyle {
    var hue: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(6)
            .fontWeight(.medium)
            .foregroundStyle(Color(UIColor(hue: hue, saturation: 0.8, brightness: 0.3, alpha: 1)))
            .clipShape(Capsule())
    }
}
