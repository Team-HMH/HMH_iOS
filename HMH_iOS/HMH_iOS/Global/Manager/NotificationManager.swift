//
//  NotificationManager.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/15/24.
//

import Foundation
import UserNotifications
import UIKit
import SwiftUI

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
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController as? UIHostingController<ContentView> {
                AppStateViewModel.shared.currentAlertType = .usePoints
                AppStateViewModel.shared.showCustomAlert = true
            }
        }

        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound])
    }
}

class AppStateViewModel: ObservableObject {
    static let shared = AppStateViewModel()
    
    @Published var showCustomAlert: Bool = true
    @Published var currentAlertType: CustomAlertType = .usePoints
    @Published var currentPoint = 0
    
    func nextAlert() {
        print("next")
        switch currentAlertType {
        case .usePoints:
            currentAlertType = .unlock
        case .unlock:
            patchPointUse()
            getUsagePoint()
            currentAlertType = .unlockComplete
            // 잠금해제하기
        case .unlockComplete:
            showCustomAlert = false
        case .insufficientPoints: break
            // 서비스 준비 페이지로 이동
        default:
            break
        }
    }
    
    func cancelAlert() {
        showCustomAlert = false
    }
    
    func onAppear() {
//        getUsagePoint()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        getCurrentPoint(date: currentDate)
    }
    
    func patchPointUse() {
        let date = "오늘 날짜"
        let request = PointRequestDTO(challengeDate: date)
        Providers.pointProvider.request(target: .patchPointUse(data: request),
                                        instance: BaseResponse<UsagePointResponseDTO>.self) { result in
            guard let data = result.data else { return }
        }
    }
    // 포인트를 사용해 이용시간 잠금을 해제할 때 사용하는 api
    
    func getUsagePoint() {
        Providers.pointProvider.request(target: .getUsagePoint,
                                        instance: BaseResponse<UsagePointResponseDTO>.self) { result in
            guard let data = result.data else { return }
            self.currentPoint = data.point
        }
    }
    // 앱 잠금해제시에 사용될 포인트를 조회하는 api입니다.
    
    func getCurrentPoint(date: String) {
        let request = PointRequestDTO(challengeDate: date)
        Providers.pointProvider.request(target: .getCurrentPoint(data: request),
                                        instance: BaseResponse<UserPointResponseDTO>.self) { result in
            guard let data = result.data else { return }
            self.currentPoint = data.point
        }
    }
}
