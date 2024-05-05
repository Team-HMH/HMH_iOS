//
//  HomeViewModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 4/11/24.
//

import SwiftUI

import FamilyControls
import DeviceActivity
import Combine
import _DeviceActivity_SwiftUI

class HomeViewModel: ObservableObject {
    @Published var totalGoalTime: TimeInterval
    @Published var currentTotalUsage: TimeInterval
    @Published var appsUsage: [AppUsage] = []
    
    init(totalGoalTime: TimeInterval = 3600, currentTotalUsage: TimeInterval = 0, appsUsage: [AppUsage] = []) {
        self.totalGoalTime = totalGoalTime
        self.currentTotalUsage = currentTotalUsage
        self.appsUsage = appsUsage
    }
    
    func remainingTimeForApp(appId: String) -> TimeInterval {
        if let appUsage = appsUsage.first(where: { $0.appId == appId }) {
            return max(appUsage.goalTime - appUsage.usedTime, 0)
        }
        return 0
    }
    
    func updateUsage(forApp appId: String, time: TimeInterval) {
        if let index = appsUsage.firstIndex(where: { $0.appId == appId }) {
            appsUsage[index].usedTime += time
            currentTotalUsage += time
        }
    }
    
    func generateDummyData() {
        appsUsage = [
            AppUsage(appId: "1", appName: "Instagram", goalTime: 60, usedTime: 45),
            AppUsage(appId: "2", appName: "YouTube", goalTime: 45, usedTime: 30),
            AppUsage(appId: "3", appName: "Twitter", goalTime: 30, usedTime: 15)
        ]
    }
}

struct AppUsage: Identifiable {
    var id = UUID()
    var appId: String // 앱 고유 식별자
    var appName: String // 앱 이름
    var goalTime: TimeInterval // 목표 사용 시간
    var usedTime: TimeInterval // 현재 사용 시간
}
