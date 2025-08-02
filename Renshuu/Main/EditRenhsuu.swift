//
//  EditRenhsuu.swift
//  Renshuu
//
//  Created by Roland Kajatin on 11/05/2025.
//

//import FoundationModels
import SwiftUI

struct EditRenhsuu: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @Bindable var renshuu: Renshuu

    @State private var showDeletionAlert = false

    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Text("Word")
                    .foregroundStyle(.secondary)

                TextField("Enter the original word", text: $renshuu.original)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }

            VStack(alignment: .leading) {
                Text("Meaning")
                    .foregroundStyle(.secondary)

                TextField("Enter the meaning of the word", text: $renshuu.translation)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
        }
        .navigationTitle("Edit")
        .toolbar {
            ToolbarItem {
                Button {
                    showDeletionAlert.toggle()
                } label: {
                    Image(systemName: "trash")
                }
            }

            if #available(iOS 26.0, *) {
                ToolbarSpacer(.fixed)
            }

            ToolbarItem {
                Button {
                    withAnimation {
                        try? modelContext.save()
                        dismiss()
                    }
                } label: {
                    Image(systemName: "checkmark")
                }
            }
        }
        .alert("Delete \"\(renshuu.original)\"?", isPresented: $showDeletionAlert) {
            Button("Delete", role: .destructive) {
                withAnimation {
                    modelContext.delete(renshuu)
                    dismiss()
                }
            }
        } message: {
            Text("This action will permanently delete the word.")
        }
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
    NavigationStack {
        PreviewContainer()
    }
}
