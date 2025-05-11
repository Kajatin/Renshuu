//
//  RoundedBorderTextFieldStyle.swift
//  Renshuu
//
//  Created by Roland Kajatin on 11/05/2025.
//

import SwiftUI

struct RoundedBorderTextFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<_Label>) -> some View {
            configuration
                .padding(.vertical, 12)
                .padding(.horizontal, 18)
                .background(
                    Capsule()
                        .stroke(Color(UIColor(hue: 0.48, saturation: 0.8, brightness: 0.3, alpha: 1)))
                )
                .foregroundStyle(Color(UIColor(hue: 0.48, saturation: 0.8, brightness: 0.3, alpha: 1)))
        }
    }
