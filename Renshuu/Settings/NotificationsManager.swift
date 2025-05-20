//
//  NotificationsManager.swift
//  Renshuu
//
//  Created by Roland Kajatin on 17/05/2025.
//

import SwiftUI

@Observable
class NotificationsManager {
    var dailyRemindersEnabled: Bool {
        didSet {
            updateStoreAndRemindersSchedule(value: dailyRemindersEnabled, forKey: "dailyRemindersEnabled")
        }
    }

    var dailyReminderDate: Date {
        didSet {
            updateStoreAndRemindersSchedule(value: dailyReminderDate.timeIntervalSince1970, forKey: "dailyReminderDate")
        }
    }

    private(set) var authorizationStatus: UNAuthorizationStatus = .notDetermined
    private let center: UNUserNotificationCenter = .current()

    init() {
        dailyRemindersEnabled = UserDefaults.standard.bool(forKey: "dailyRemindersEnabled")

        let timestamp = UserDefaults.standard.double(forKey: "dailyReminderDate")
        if timestamp == 0 {
            dailyReminderDate = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
        } else {
            dailyReminderDate = Date(timeIntervalSince1970: timestamp)
        }

        determineAuthorizationStatus()
    }

    func requestAuthorization(completionHandler: ((Bool) -> Void)? = nil) {
        determineAuthorizationStatus()

        guard authorizationStatus == .notDetermined else {
            if let completionHandler = completionHandler {
                completionHandler(authorizationStatus == .authorized)
            }
            return
        }

        center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
            self.determineAuthorizationStatus()
            if let completionHandler = completionHandler {
                completionHandler(granted)
            }
        }
    }

    func determineAuthorizationStatus() {
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus

                if settings.authorizationStatus == .denied {
                    self.dailyRemindersEnabled = false
                }
            }
        }
    }

    func scheduleDailyReminder() {
        center.removePendingNotificationRequests(withIdentifiers: ["RenshuuDailyReminder"])

        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Time to practice!"

        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: dailyReminderDate)

        var dateComponents = DateComponents()
        dateComponents.hour = components.hour
        dateComponents.minute = components.minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "RenshuuDailyReminder", content: content, trigger: trigger)

        center.add(request)
    }

    private func updateStoreAndRemindersSchedule(value: Any?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)

        if dailyRemindersEnabled {
            scheduleDailyReminder()
        } else {
            center.removePendingNotificationRequests(withIdentifiers: ["RenshuuDailyReminder"])
        }
    }
}
