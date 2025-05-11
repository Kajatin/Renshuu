//
//  WordOfTheDay.swift
//  Renshuu
//
//  Created by Roland Kajatin on 08/05/2025.
//

import SwiftUI

struct WordOfTheDay: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Word of the Day")
                .font(.system(size: 14, weight: .light))
                .opacity(0.7)

            HStack {
                Spacer()

                Text("til gengæld")
                    .font(.system(size: 24, weight: .medium, design: .serif))

                Spacer()
            }
            .padding(.vertical, 32)
        }
        .padding(.top)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .background(
            Rectangle()
                .fill(Color(UIColor(hue: 0.48, saturation: 0.8, brightness: 0.3, alpha: 1)))
                .shadow(color: .neutral950.opacity(0.2), radius: 8, x: 0, y: 4)
                .ignoresSafeArea(.all, edges: .top)
        )
        .foregroundStyle(Color(UIColor(hue: 0.48, saturation: 0.2, brightness: 1, alpha: 1)))
    }
}

#Preview {
    WordOfTheDay()
}
