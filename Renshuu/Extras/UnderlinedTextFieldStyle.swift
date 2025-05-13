//
//  UnderlinedTextFieldStyle.swift
//  Renshuu
//
//  Created by Roland Kajatin on 11/05/2025.
//

import SwiftUI

struct UnderlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
            .background(
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.neutral500)
                }
            )
            .foregroundStyle(Color.appHighSaturation)
    }
}
