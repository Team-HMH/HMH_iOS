//
//  AppDelegate.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/15/24.
//

import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    var appStateViewModel = AppStateViewModel.shared
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotificationManager.shared.requestAuthorization()
        UNUserNotificationCenter.current().delegate = NotificationManager.shared
        // Check if launched from notification
        if let launchOptions = launchOptions,
           let notification = launchOptions[.remoteNotification] as? [String: AnyObject] {
            handleRemoteNotification(notification)
        }
        

        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Send the device token to your server
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                       fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
          handleRemoteNotification(userInfo)
          completionHandler(.newData)
      }
      
      private func handleRemoteNotification(_ userInfo: [AnyHashable: Any]) {
          // Handle the notification and show an alert
          if let aps = userInfo["aps"] as? [String: AnyObject],
             let alert = aps["status"] as? [String: String] {
              appStateViewModel.showCustomAlert = true
          }
      }
}
