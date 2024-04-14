//
//  HomeViewModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 4/11/24.
//

import Foundation

import Combine

class HomeViewModel {
    @Published var totalGoalTime: TimeInterval // 전체 목표 사용 시간
    @Published var currentTotalUsage: TimeInterval // 현재 총 사용량
    @Published var appsUsage: [AppUsage] // 앱별 사용 정보

    init(totalGoalTime: TimeInterval = 3600, currentTotalUsage: TimeInterval = 0, appsUsage: [AppUsage] = []) {
        self.totalGoalTime = totalGoalTime
        self.currentTotalUsage = currentTotalUsage
        self.appsUsage = appsUsage
    }

    // 남은 앱 사용 시간 계산
    func remainingTimeForApp(appId: String) -> TimeInterval {
        if let appUsage = appsUsage.first(where: { $0.appId == appId }) {
            return max(appUsage.goalTime - appUsage.usedTime, 0)
        }
        return 0
    }

    // 앱 사용 시간 업데이트
    func updateUsage(forApp appId: String, time: TimeInterval) {
        if let index = appsUsage.firstIndex(where: { $0.appId == appId }) {
            appsUsage[index].usedTime += time
            currentTotalUsage += time
        }
    }
}

// 각 앱의 사용 정보를 저장할 구조체
struct AppUsage: Identifiable {
    var id = UUID()
    var appId: String // 앱 고유 식별자
    var appName: String // 앱 이름
    var goalTime: TimeInterval // 목표 사용 시간
    var usedTime: TimeInterval // 현재 사용 시간
}
