//
//  ShieldActionExtension.swift
//  ShieldActionExtension
//
//  Created by 이지희 on 5/15/24.
//

import SwiftUI

import ManagedSettings

// Override the functions below to customize the shield actions used in various situations.
// The system provides a default response for any functions that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldActionExtension: ShieldActionDelegate {
    let userNotiCenter = UNUserNotificationCenter.current()
    
    override func handle(action: ShieldAction,
                         for application: ApplicationToken,
                         completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        switch action {
        case .primaryButtonPressed:
            completionHandler(.close)
        case .secondaryButtonPressed:
            requestSendNoti(seconds: 0.5, 
                            title: Application(token: application).localizedDisplayName ?? "")
            completionHandler(.defer)
        @unknown default:
            fatalError()
        }
    }
    
    override func handle(action: ShieldAction,
                         for webDomain: WebDomainToken,
                         completionHandler: @escaping (ShieldActionResponse) -> Void) {
        switch action {
        case .primaryButtonPressed:
            completionHandler(.close)
        case .secondaryButtonPressed:
                requestSendNoti(seconds: 0.5, 
                                title: WebDomain(token: webDomain).domain ?? "")
                completionHandler(.defer)
        @unknown default:
            fatalError("sheild Action Error")
        }
    }
    
    // MARK: ActivityCategoryToken으로 설정된 웹에서 버튼 클릭 시 동작 설정
    override func handle(
        action: ShieldAction,
        for category: ActivityCategoryToken,
        completionHandler: @escaping (ShieldActionResponse) -> Void) {
            switch action {
            case .primaryButtonPressed:
                completionHandler(.close)
            case .secondaryButtonPressed:
                requestSendNoti(seconds: 0.5,
                                title: ActivityCategory(token: category).localizedDisplayName ?? "")
            @unknown default:
                fatalError("shield Action Error")
            }
        }
    
    private func requestSendNoti(seconds: Double, title: String) {
        let notiContent = UNMutableNotificationContent()
        notiContent.title = "스크린타임 잠금 해제하기"
        notiContent.body = "잠긴 화면을 풀려면 여기를 클릭해주세요"
        notiContent.userInfo = ["AppName": title] // 푸시 받을때 오는 데이터
        
        // 알림이 trigger되는 시간 설정
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: notiContent,
            trigger: trigger
        )
        
        userNotiCenter.add(request) { (error) in
            print(#function, error)
        }
        
    }
}
