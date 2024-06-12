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
        // Check if launched from notification
        if let launchOptions = launchOptions,
           let notification = launchOptions[.remoteNotification] as? [String: AnyObject] {
            handleRemoteNotification(notification)
        }
        BGTaskScheduler.shared.register(forTaskWithIdentifier: taskIdentifier, using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        scheduleAppRefresh()
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
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleAppRefresh()
    }
    
    private func handleRemoteNotification(_ userInfo: [AnyHashable: Any]) {
        // Handle the notification and show an alert
        if let aps = userInfo["aps"] as? [String: AnyObject],
           let alert = aps["status"] as? [String: String] {
            appStateViewModel.showCustomAlert = true
        }
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: taskIdentifier)
        
        // 한국 시간으로 23:59 설정
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        let now = Date()
        let nowComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: now)
        
        if let nextMidnight = calendar.date(bySettingHour: 23, minute: 59, second: 0, of: now) {
            request.earliestBeginDate = nextMidnight > now ? nextMidnight : calendar.date(byAdding: .day, value: 1, to: nextMidnight)
        }
        
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Scheduled app refresh for: \(String(describing: request.earliestBeginDate))")
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    func handleAppRefresh(task: BGAppRefreshTask) {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        
        let operation = RealmUpdateOperation()
        queue.addOperation(operation)
        
        task.expirationHandler = {
            queue.cancelAllOperations()
        }
        
        operation.completionBlock = {
            task.setTaskCompleted(success: !operation.isCancelled)
            print("BGTask completed: \(operation.isCancelled ? "Cancelled" : "Success")")
        }
        
        // 다음 작업을 예약합니다.
        scheduleAppRefresh()
    }
}
