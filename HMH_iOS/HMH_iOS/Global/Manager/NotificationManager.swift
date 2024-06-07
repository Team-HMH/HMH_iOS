//
//  NotificationManager.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/15/24.
//

import Foundation
import UserNotifications
import UIKit

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    self.registerForRemoteNotifications()
                }
            } else if let error = error {
                print("Authorization failed: \(error.localizedDescription)")
            }
        }
    }

    private func registerForRemoteNotifications() {
        UIApplication.shared.registerForRemoteNotifications()
    }

    // UNUserNotificationCenterDelegate method
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle the notification response
        
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound])
    }
}

class AppStateViewModel: ObservableObject {
    static let shared = AppStateViewModel()
    
    @Published var showCustomAlert: Bool = false
}
