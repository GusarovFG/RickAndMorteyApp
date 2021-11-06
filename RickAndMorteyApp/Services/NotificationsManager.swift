//
//  NotificationsManager.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 06.11.2021.
//

import Foundation
import UserNotifications


class NotificationsManager {

    static let shared = NotificationsManager()

    private init() {}

    let notificationsCenter = UNUserNotificationCenter.current()

    func requestAuthorization() {
        notificationsCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print(granted)
            guard granted else {return}
            self.getNotificationSettings()
        }
    }

    func getNotificationSettings() {
        notificationsCenter.getNotificationSettings { settings in
            print(settings)
        }
    }

    func scheduleNotifitacons() {

        let content = UNMutableNotificationContent()

        content.title = "Рик и морти уже заждолись"
        content.body = "Окунись в безумный мир вселенной Рика и Морти"
        content.sound = UNNotificationSound.default
        content.badge = 1

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let identifire = "Locale Notification"
        let request = UNNotificationRequest(identifier: identifire, content: content, trigger: trigger)

        notificationsCenter.add(request) { error in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
