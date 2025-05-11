//
//  CreateNewRenshuu.swift
//  Renshuu
//
//  Created by Roland Kajatin on 07/05/2025.
//

import SwiftUI

struct CreateNewRenshuu: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @AppStorage("onboardingNeeded") var onboardingNeeded: Bool = true
    
    @State private var original: String = ""
    @State private var translation: String = ""
    
    var isOnboarding = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(UIColor(hue: 0.48, saturation: 0.2, brightness: 1, alpha: 1))
                .ignoresSafeArea(.all, edges: .all)

            NavigationBackButton(hue: 0.48)

            VStack {
                Text("New")
                    .foregroundStyle(Color(UIColor(hue: 0.48, saturation: 0.7, brightness: 0.4, alpha: 1)))
                    .font(.system(size: 24, design: .serif))
                    .padding(.top, 20)
                
                Spacer()

                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("Original")
                            .font(.system(size: 14, weight: .light))
                            .opacity(0.7)
                        
                        TextField("Enter the original word", text: $original)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Translation")
                            .font(.system(size: 14, weight: .light))
                            .opacity(0.7)
                        
                        TextField("Enter the translation", text: $translation)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())

                Spacer()

                Button {
                    withAnimation {
                        modelContext.insert(Renshuu(original: original, translation: translation))
                        onboardingNeeded = false
                        if !isOnboarding {
                            dismiss()
                        }
                    }
                } label: {
                    Text(isOnboarding ? "Get started" : "Save")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(CuteButtonStyle(hue: 0.48))
                .disabled(original.isEmpty || translation.isEmpty)
                .opacity(original.isEmpty || translation.isEmpty ? 0.7 : 1.0)
            }
            .scenePadding()
        }
        .background(EnableSwipeBackGesture())
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        CreateNewRenshuu()
            .modelContainer(for: Renshuu.self, inMemory: true)
    }
}
