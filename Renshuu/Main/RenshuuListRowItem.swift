//
//  RenshuuListRowItem.swift
//  Renshuu
//
//  Created by Roland Kajatin on 06/05/2025.
//

import SwiftUI

struct RenshuuListRowItem: View {
    var renshuu: Renshuu
    
    var body: some View {
        HStack {
            Text(renshuu.original)
                .foregroundStyle(.neutral950)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    RenshuuListRowItem(renshuu: .init(original: "til gengæld", translation: "on the other hand"))
}
