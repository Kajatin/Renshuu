//
//  NavigationBackButton.swift
//  Renshuu
//
//  Created by Roland Kajatin on 07/05/2025.
//

import SwiftUI

struct NavigationBackButton: View {
    @Environment(\.dismiss) private var dismiss

    var hue: Double

    var body: some View {
        Button {
            withAnimation {
                dismiss()
            }
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
        }
        .buttonStyle(CuteButtonStyleSecondary(hue: hue))
        .opacity(0.8)
    }
}
