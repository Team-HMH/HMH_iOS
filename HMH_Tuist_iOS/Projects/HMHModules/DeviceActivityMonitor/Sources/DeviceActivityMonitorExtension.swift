//
//  DeviceActivityMonitorExtension.swift
//  DeviceMonitor
//
//  Created by 지희의 MAC on 1/4/24.
//
//

import DeviceActivity
import ManagedSettings
import Foundation
import UserNotifications

import SwiftUI
import FamilyControls

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    
    @AppStorage(AppStorageKey.selectionApp.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var selectionApps = FamilyActivitySelection()
    
    @StateObject var screenTimeVM = ScreenTimeViewModel()
    
    let store = ManagedSettingsStore()
    let userNotiCenter = UNUserNotificationCenter.current()
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        store.shield.applications = nil
    }
    
    //threshold에 도착하면 행동한다
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        store.shield.applications = selectionApps.applicationTokens // 이러면 다른 앱도 잠김
        Task {
            await screenTimeVM.handleSetBlockApplication()
        }
        let notiContent = UNMutableNotificationContent()
        notiContent.title = "하면함"
        notiContent.body = "이용 시간이 종료 되었습니다."
        notiContent.userInfo = ["token": ""] // 푸시 받을때 오는 데이터
        
        // 알림이 trigger되는 시간 설정
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: notiContent,
            trigger: trigger
        )
        
        self.userNotiCenter.add(request) { (error) in
            print(#function, error as Any)
        }
        
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        // Handle the warning before the interval starts.
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        //NotificationManager.shared.scheduleNotification()
        
        // Handle the warning before the interval ends.
        
    }
    
    //threshold 시간이 되면 경고를 준다
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        //store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.all()
        let notiContent = UNMutableNotificationContent()
        notiContent.title = "하면함"
        notiContent.body = "이용 시간이 종료되었습니다. 곧 어플이 잠깁니다."
        notiContent.userInfo = ["status": ""] // 푸시 받을때 오는 데이터
        
        // 알림이 trigger되는 시간 설정
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: notiContent,
            trigger: trigger
        )
        
        userNotiCenter.add(request) { (error) in
            print(#function, error as Any)
        }
        
        //NotificationManager.shared.scheduleNotification()
        
    }
}
