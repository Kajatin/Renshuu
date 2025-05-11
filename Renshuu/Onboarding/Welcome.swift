//
//  Welcome.swift
//  Renshuu
//
//  Created by Roland Kajatin on 11/05/2025.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                Color(UIColor(hue: 0.48, saturation: 0.2, brightness: 1, alpha: 1))
                    .ignoresSafeArea(.all, edges: .all)
                
                VStack {
                    Text("Welcome")
                        .foregroundStyle(Color(UIColor(hue: 0.48, saturation: 0.7, brightness: 0.4, alpha: 1)))
                        .font(.system(size: 24, design: .serif))
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Renshuu helps you learn new words and phrases.")
                        
                        Text("It uses a simple algorithm to determine which words should be presented to you based on how well you know them.")
                        
                        Text("After a word is presented to you, you'll have to think of its meaning and then provide a score for how easily, if at all, you could recall it.")
                        
                        Text("Start by adding your first word or phrase.")
                    }
                    .foregroundStyle(Color(UIColor(hue: 0.48, saturation: 0.7, brightness: 0.4, alpha: 1)))
                    
                    Spacer()
                    
                    NavigationLink(destination: CreateNewRenshuu(isOnboarding: true)) {
                        Text("Continue")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(CuteButtonStyle(hue: 0.48))
                }
                .scenePadding()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    Welcome()
}
