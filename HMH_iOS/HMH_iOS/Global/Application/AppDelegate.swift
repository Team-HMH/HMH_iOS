//
//  AppDelegate.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/15/24.
//

import UIKit
import SwiftUI
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
        registerBackgroundTasks()
        scheduleDailyResetTask()
        
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
        BGTaskScheduler.shared.getPendingTaskRequests { tasks in
            if tasks.isEmpty {
                self.scheduleDailyResetTask()
            }
        }
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
        
        // 챌린지 시작 날짜 가져오기
        let challengeStartDateString = appStateViewModel.challengeModel.startDate
        guard let challengeStartDate = dateFormatter.date(from: challengeStartDateString) else {
            print("Invalid challenge start date format")
            return
        }
        
        // Calculate the date range from the last login date to yesterday
        var date = lastDate
        var dateArray: [(dateString: String, index: Int)] = []
        
        while date < currentDate {
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            let dateString = dateFormatter.string(from: date)
            
            if dateString < currentDateString {
                let index = Calendar.current.dateComponents([.day], from: challengeStartDate, to: date).day ?? 0
                dateArray.append((dateString: dateString, index: index))
            }
        }
        
        sendDailyChallengeData(dates: dateArray)
        UserDefaults.standard.lastSentDate = currentDateString
    }
    
    private func sendDailyChallengeData(dates: [(dateString: String, index: Int)]) {
        let finishedChallenges = dates.map { dateInfo -> FinishedDailyChallenge in
            return FinishedDailyChallenge(challengePeriodIndex: dateInfo.index, isSuccess: true)
        }
        
        let midnightDTO = MidnightRequestDTO(finishedDailyChallenges: finishedChallenges)
        
        Providers.challengeProvider.request(target: .postDailyChallenge(data: midnightDTO), instance: BaseResponse<EmptyResponseDTO>.self) { result in
            print("Daily challenge data sent successfully.")
        }
    }
    
    
    // 자정 데이터 초기화
    private func registerBackgroundTasks() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: taskIdentifier, using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }
    
    private func scheduleDailyResetTask() {
        let request = BGAppRefreshTaskRequest(identifier: taskIdentifier)
        request.earliestBeginDate = Date().addingTimeInterval(24*60*60) // 24시간 후에 실행
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Unable to submit task: \(error.localizedDescription)")
        }
    }
    
    private func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleDailyResetTask()
        task.setTaskCompleted(success: true)
    }
    
}
