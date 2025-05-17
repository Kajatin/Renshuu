//
//  ConstantExtensions.swift
//  Renshuu
//
//  Created by Roland Kajatin on 14/05/2025.
//

import SwiftUI

extension CGFloat {
    static let appHue: CGFloat = 0.54
}

extension Color {
    static let appLowSaturation: Color = Color(UIColor(hue: .appHue, saturation: 0.05, brightness: 1, alpha: 1))
    static let appHighSaturation: Color = Color(UIColor(hue: .appHue, saturation: 0.8, brightness: 0.3, alpha: 1))
}
