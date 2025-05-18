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
            print("didset")
            UserDefaults.standard.set(dailyRemindersEnabled, forKey: "dailyRemindersEnabled")
            
            if dailyRemindersEnabled {
                scheduleDailyReminder()
            } else {
                center.removePendingNotificationRequests(withIdentifiers: ["RenshuuDailyReminder"])
                print("cleared notifications")
            }
        }
    }

    private(set) var authorizationStatus: UNAuthorizationStatus = .notDetermined
    private let center: UNUserNotificationCenter = .current()

    init() {
        dailyRemindersEnabled = UserDefaults.standard.bool(forKey: "dailyRemindersEnabled")
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

        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "RenshuuDailyReminder", content: content, trigger: trigger)
        center.add(request)
        
        print("scheudled notification")
    }
}
