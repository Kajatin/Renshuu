//
//  Settings.swift
//  Renshuu
//
//  Created by Roland Kajatin on 15/05/2025.
//

import SwiftUI

struct Settings: View {
    @AppStorage("reversedPracticeOrder") var reversedPracticeOrder: Bool = false

    @State private var showDeleteAllDataAlert: Bool = false

    @Environment(\.modelContext) private var modelContext
    @Environment(NotificationsManager.self) var notificationsManager

    var body: some View {
        Form {
            Section(
                header: Text("Practice"),
                footer: Text("Reverses the order in which the word pair is shown during practice. Defaults to showing the foreign word first.")
            ) {
                Toggle("Reversed order", isOn: $reversedPracticeOrder)
            }

            Section(
                header: Text("Notifications"),
                footer: Text("Daily notifications simply remind you to practice your vocabulary. Configure a time for the reminders that suits you best.")
            ) {
                @Bindable var notificationsManager = notificationsManager
                Toggle("Practice reminder", isOn: $notificationsManager.dailyRemindersEnabled)
                    .onChange(of: notificationsManager.dailyRemindersEnabled) { _, isOn in
                        if isOn {
                            notificationsManager.requestAuthorization()
                        }
                    }

                DatePicker(selection: $notificationsManager.dailyReminderDate, displayedComponents: .hourAndMinute) {
                    Text("Reminder time")
                }
            }

            Section {
                Button(role: .destructive) {
                    showDeleteAllDataAlert.toggle()
                } label: {
                    Text("Delete all words")
                }
            }
        }
        .navigationTitle("Settings")
        .alert("Delete all words?", isPresented: $showDeleteAllDataAlert) {
            Button("Delete", role: .destructive) {
                try? modelContext.delete(model: Renshuu.self)
            }
        } message: {
            Text("Removes all saved words. This action cannot be undone.")
        }
        .onAppear {
            notificationsManager.determineAuthorizationStatus()
        }
    }
}

#Preview {
    @Previewable var notificationsManager = NotificationsManager()
    NavigationStack {
        Settings()
    }
    .environment(notificationsManager)
    .modelContainer(for: Renshuu.self, inMemory: true)
}
