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
            Color.appLowSaturation
                .ignoresSafeArea(.all, edges: .all)

            VStack {
                Spacer()

                VStack(spacing: 32) {
                    VStack(alignment: .leading) {
                        Text("Word")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.neutral600)
                        
                        TextField("Enter the original word", text: $original)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Meaning")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.neutral600)
                        
                        TextField("Enter the meaning of the word", text: $translation)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }
                }
                .textFieldStyle(UnderlinedTextFieldStyle())

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
                .buttonStyle(CuteButtonStyle(hue: .appHue))
                .disabled(original.isEmpty || translation.isEmpty)
                .opacity(original.isEmpty || translation.isEmpty ? 0.7 : 1.0)
            }
            .padding()
        }
        .navigationTitle("New")
    }
}

#Preview {
    NavigationStack {
        CreateNewRenshuu()
    }
    .modelContainer(for: Renshuu.self, inMemory: true)
}
