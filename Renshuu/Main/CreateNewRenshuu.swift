//
//  CreateNewRenshuu.swift
//  Renshuu
//
//  Created by Roland Kajatin on 07/05/2025.
//

import SwiftUI

struct CreateNewRenshuu: View {
    var collection: Collection
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(NotificationsManager.self) private var notificationsManager

    @AppStorage("onboardingNeeded") var onboardingNeeded: Bool = true
    @AppStorage("askForNotifications") var askForNotifications: Bool = true

    @State private var original: String = ""
    @State private var translation: String = ""
    @State private var showNotificationsSheet = false

    @FocusState private var originalInputFocused: Bool

    var isOnboarding = false

    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Text("Word")
                    .foregroundStyle(.secondary)

                TextField("Enter the original word", text: $original)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($originalInputFocused)
            }

            VStack(alignment: .leading) {
                Text("Meaning")
                    .foregroundStyle(.secondary)

                TextField("Enter the meaning of the word", text: $translation)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
        }
        .navigationTitle("New")
        .onAppear {
            originalInputFocused.toggle()
        }
        .toolbar {
            ToolbarItem {
                Button {
                    withAnimation {
                        modelContext.insert(Renshuu(original: original, translation: translation, collection: collection))
                        onboardingNeeded = false
                        if !isOnboarding && askForNotifications {
                            showNotificationsSheet.toggle()
                        } else {
                            dismiss()
                        }
                    }
                } label: {
                    Image(systemName: isOnboarding ? "chevron.right" : "checkmark")
                }
            }
        }
        .sheet(
            isPresented: $showNotificationsSheet,
            onDismiss: {
                askForNotifications = false; dismiss()
            }
        ) {
            VStack(spacing: 24) {
                Spacer()
                
                Image("NotificationScreenshot")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 28))
                
                Text("Daily Reminders")
                    .font(.largeTitle.bold())
                    .padding(.vertical)
                    .foregroundStyle(.accent.gradient)

                Text("Enable notifications and get daily reminders to help you practice. You’ll be much more likely to remember new words and phrases if you practice regularly.")
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                
                Spacer()

                Button {
                    withAnimation {
                        notificationsManager.requestAuthorization() { granted in
                            DispatchQueue.main.async {
                                if granted {
                                    notificationsManager.dailyRemindersEnabled = true
                                }

                                showNotificationsSheet.toggle()
                            }
                        }
                    }
                } label: {
                    Text("Enable")
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .font(.headline)
                }
                .buttonStyle(.bordered)
                .tint(.accentColor)
            }
            .scenePadding()
        }
    }
}

#Preview {
    var notificationsManager = NotificationsManager()
    NavigationStack {
        CreateNewRenshuu(collection: Collection(title: "Example"))
    }
    .modelContainer(for: Renshuu.self, inMemory: true)
    .environment(notificationsManager)
}
