//
//  AppDelegate.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/15/24.
//

import UIKit
import UserNotifications
import BackgroundTasks

class AppDelegate: NSObject, UIApplicationDelegate {
    var appStateViewModel = AppStateViewModel.shared
    let taskIdentifier = "com.HMH.dailyTask"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotificationManager.shared.requestAuthorization()
        UNUserNotificationCenter.current().delegate = NotificationManager.shared
        if let launchOptions = launchOptions,
           let notification = launchOptions[.remoteNotification] as? [String: AnyObject] {
            handleRemoteNotification(notification)
        }
        
        sendDailyChallengeDataIfNeeded()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Send the device token to your server
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        handleRemoteNotification(userInfo)
        completionHandler(.newData)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    private func handleRemoteNotification(_ userInfo: [AnyHashable: Any]) {
        // Handle the notification and show an alert
        if let aps = userInfo["aps"] as? [String: AnyObject],
           let alert = aps["status"] as? [String: String] {
            appStateViewModel.showCustomAlert = true
        }
    }
    
}

extension AppDelegate {
    private func sendDailyChallengeDataIfNeeded() {
        guard let lastLoginDate = UserDefaults.standard.lastSentDate else {
            UserDefaults.standard.lastSentDate = Date().formattedString()
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let lastDate = dateFormatter.date(from: lastLoginDate) else {
            UserDefaults.standard.lastSentDate = Date().formattedString()
            return
        }
        
        let currentDate = Date()
        let currentDateString = currentDate.formattedString()
        
        if lastLoginDate == currentDateString {
            return
        }
        
        // Calculate the date range from the last login date to yesterday
        var date = lastDate
        var dateArray: [String] = []
        
        while date < currentDate {
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            let dateString = dateFormatter.string(from: date)
            if dateString < currentDateString {
                dateArray.append(dateString)
            }
        }
        
        sendDailyChallengeData(dates: dateArray)
        UserDefaults.standard.lastSentDate = currentDateString
    }
    
    private func sendDailyChallengeData(dates: [String]) {
        let finishedChallenges = dates.map { date -> FinishedDailyChallenge in
            return FinishedDailyChallenge(challengeDate: date, isSuccess: true)
        }
        
        let midnightDTO = MidnightRequestDTO(finishedDailyChallenges: finishedChallenges)
        
        Providers.challengeProvider.request(target: .postDailyChallenge(data: midnightDTO), instance: BaseResponse<EmptyResponseDTO>.self) { result in
            print("Daily challenge data sent successfully.")
        }
    }
    
}
