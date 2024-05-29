//
//  ActivityModel.swift
//  HMHDeviceActivityReport
//
//  Created by 이지희 on 5/12/24.
//

import Foundation

import ManagedSettings

struct ActivityReport {
    let totalDuration: TimeInterval
    let apps: [AppDeviceActivity]
}

struct AppDeviceActivity: Identifiable {
    var id: String
    var displayName: String
    var duration: TimeInterval
    var numberOfPickups: Int
    var token: ApplicationToken?
}

struct TotalActivityModel: Identifiable {
    var id: String
    var totalTime: Int
    var remainTime: Int
    var totalGoalTime: Int
    var titleState: [String]
}

extension TimeInterval {
    /// TimeInterval 타입 값을 00:00 형식의 String으로 변환해주는 메서드
    func toString() -> String {
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        if hours < 1{
            return String(format: "%d분", minutes)
        } else {
            return String(format: "%d시간 %d분", hours, minutes)
        }
    }
}
