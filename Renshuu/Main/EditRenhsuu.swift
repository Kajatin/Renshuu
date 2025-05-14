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
        ZStack {
            Color.appLowSaturation
                .ignoresSafeArea(.all, edges: .all)

            VStack {
                Spacer()

                VStack(spacing: 32) {
                    VStack(alignment: .leading) {
                        Text("Word")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.neutral600)

                        TextField("Enter the original word", text: $renshuu.original)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }

                    VStack(alignment: .leading) {
                        Text("Meaning")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.neutral600)

                        TextField("Enter the meaning of the word", text: $renshuu.translation)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }
                }
                .textFieldStyle(UnderlinedTextFieldStyle())

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
                    .buttonStyle(CuteButtonStyle(hue: .appHue))

                    Button {
                        withAnimation {
                            modelContext.delete(renshuu)
                            dismiss()
                        }
                    } label: {
                        Text("Delete")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(CuteButtonStyleLight(hue: .appHue))
                }
            }
            .padding()
        }
        .navigationTitle("Edit")
    }
}

private struct PreviewContainer: View {
    @State private var renshuu = Renshuu(original: "til gengæld", translation: "on the other hand")

    var body: some View {
        NavigationStack {
            EditRenhsuu(renshuu: renshuu)
        }
        .modelContainer(for: Renshuu.self, inMemory: true)
    }
}

#Preview {
    PreviewContainer()
}
