//
//  EditRenhsuu.swift
//  Renshuu
//
//  Created by Roland Kajatin on 11/05/2025.
//

import SwiftUI

struct EditRenhsuu: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var renshuu: Renshuu

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(UIColor(hue: 0.48, saturation: 0.2, brightness: 1, alpha: 1))
                .ignoresSafeArea(.all, edges: .all)

            NavigationBackButton(hue: 0.48)

            VStack {
                Text("Edit")
                    .foregroundStyle(Color(UIColor(hue: 0.48, saturation: 0.7, brightness: 0.4, alpha: 1)))
                    .font(.system(size: 24, design: .serif))
                    .padding(.top, 20)

                Spacer()

                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("Original")
                            .font(.system(size: 14, weight: .light))
                            .opacity(0.7)

                        TextField("Enter the original word", text: $renshuu.original)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }

                    VStack(alignment: .leading) {
                        Text("Translation")
                            .font(.system(size: 14, weight: .light))
                            .opacity(0.7)

                        TextField("Enter the translation", text: $renshuu.translation)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())

                Spacer()

                VStack(spacing: 12) {
                    Button {
                        withAnimation {
                            try? modelContext.save()
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(CuteButtonStyle(hue: 0.48))
                    
                    Button {
                        withAnimation {
                            modelContext.delete(renshuu)
                            dismiss()
                        }
                    } label: {
                        Text("Delete")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(CuteButtonStyleLight(hue: 0.48))
                }
            }
            .scenePadding()
        }
        .background(EnableSwipeBackGesture())
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

private struct PreviewContainer: View {
    @State private var renshuu = Renshuu(original: "til gengæld", translation: "on the other hand")

    var body: some View {
        NavigationStack {
            EditRenhsuu(renshuu: renshuu)
                .modelContainer(for: Renshuu.self, inMemory: true)
        }
    }
}

#Preview {
    PreviewContainer()
}
