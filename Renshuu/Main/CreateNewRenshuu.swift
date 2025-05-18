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
    @Environment(NotificationsManager.self) private var notificationsManager

    @AppStorage("onboardingNeeded") var onboardingNeeded: Bool = true
    @AppStorage("askForNotifications") var askForNotifications: Bool = true

    @State private var original: String = ""
    @State private var translation: String = ""
    @State private var showNotificationsSheet = false

    var isOnboarding = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.neutral50
                .ignoresSafeArea(.all, edges: .all)

            VStack {
                Spacer()

                VStack(spacing: 32) {
                    VStack(alignment: .leading) {
                        Text("Word")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.neutral500)

                        TextField("Enter the original word", text: $original)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }

                    VStack(alignment: .leading) {
                        Text("Meaning")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.neutral500)

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
                        if !isOnboarding && askForNotifications {
                            showNotificationsSheet.toggle()
                        } else {
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
        .sheet(isPresented: $showNotificationsSheet, onDismiss: { askForNotifications = false; dismiss() }) {
            ZStack {
                Color.neutral50
                    .ignoresSafeArea(.all, edges: .all)

                GeometryReader { geo in
                    VStack(spacing: 40) {
                        Text("Daily Reminders")
                            .foregroundStyle(Color.appHighSaturation)
                            .font(.system(size: 36, weight: .medium, design: .serif))
                            .padding(.top, 40)

                        ScrollView {
                            VStack(alignment: .leading, spacing: 20) {
                                Group {
                                    Text("Enable notifications and get daily reminders to help you practice.")
                                    Text("You’ll be much more likely to remember new words and phrases if you practice regularly.")
                                }
                                .foregroundStyle(.neutral950)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: geo.size.width * 0.8)
                            }
                        }

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
                        }
                        .buttonStyle(CuteButtonStyle(hue: .appHue))
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateNewRenshuu()
    }
    .modelContainer(for: Renshuu.self, inMemory: true)
}
