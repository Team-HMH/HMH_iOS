//
//  NotificationManager.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/15/24.
//

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
        AppStateViewModel.shared.onAppear()
        AppStateViewModel.shared.currentAlertType = .usePoints
        AppStateViewModel.shared.showCustomAlert = true
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound])
    }
}

class AppStateViewModel: ObservableObject {
    static let shared = AppStateViewModel()
    @StateObject var screenTimeModel = ScreenTimeViewModel()
    @StateObject var challengeModel = ChallengeViewModel()
    
    @Published var showCustomAlert: Bool = false
    @Published var currentAlertType: CustomAlertType = .usePoints
    @Published var currentPoint = 0
    @Published var usagePoint = 0
    
    func nextAlert() {
        print("next")
        switch currentAlertType {
        case .usePoints:
            currentAlertType = .unlock
        case .unlock:
            patchPointUse()
            getUsagePoint()
        case .unlockComplete:
            showCustomAlert = false
        case .insufficientPoints:
            showCustomAlert = false
            UserManager.shared.appStateString = "servicePrepare"
        default:
            break
        }
    }
    
    func cancelAlert() {
        showCustomAlert = false
    }
    
    func onAppear() {
        getUsagePoint()
        getCurrentPoint()
    }
    
    /// 포인트 사용해서 잠금 해제하는 부분
    func patchPointUse() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        let request = PointRequestDTO(challengeDate: currentDate)
        Providers.pointProvider.request(target: .patchPointUse(data: request),
                                        instance: BaseResponse<PatchPointUseResponseDTO>.self) { result in
            if result.status == 400 {
                self.currentAlertType = .insufficientPoints
            } else if result.status == 200 {
                // 특정 앱이 아닌 설정해둔 모든 앱이 잠기므로 모든 앱 잠금 해제
                self.screenTimeModel.unblockAllApps()
                self.currentAlertType = .unlockComplete
                self.challengeModel.sendFailChallenge(date: Date().formattedString())
            } else {
                self.showCustomAlert = false
            }
            guard let data = result.data else { return }
        }
    }
    // 포인트를 사용해 이용시간 잠금을 해제할 때 사용하는 api
    
    func getUsagePoint() {
        Providers.pointProvider.request(target: .getUsagePoint,
                                        instance: BaseResponse<UsagePointResponseDTO>.self) { result in
            guard let data = result.data else { return }
            self.usagePoint = data.usagePoint
        }
    }
    // 앱 잠금해제시에 사용될 포인트를 조회하는 api입니다.
    
    func getCurrentPoint() {
        Providers.pointProvider.request(target: .getCurrentPoint,
                                        instance: BaseResponse<Int>.self) { result in
            guard let data = result.data else { return }
            self.currentPoint = data
        }
    }
}
