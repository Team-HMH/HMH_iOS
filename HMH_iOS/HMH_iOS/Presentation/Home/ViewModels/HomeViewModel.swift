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

class HomeViewModel: ObservableObject {
    @AppStorage(AppStorageKey.totalgoaltime.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var totalGoalTimeDouble = 0
    @AppStorage(AppStorageKey.appGoalTime.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var appGoalTimeDouble = 0
    @AppStorage(AppStorageKey.usageGrade.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var usageGrade = ""
    
    @AppStorage("handleUsage") var isNotHandleUsage: Bool = true
    @StateObject var screenTimeVM = ScreenTimeViewModel()
    
    init(){
        getDailyChallenge()
        print("usageGrade:\(usageGrade)")
    }
    
    func getDailyChallenge() {
        Providers.challengeProvider.request(target: .getdailyChallenge, instance: BaseResponse<HomeChallengeResponseDTO>.self) { result in
            if let data = result.data {
                self.totalGoalTimeDouble = data.goalTime
                self.appGoalTimeDouble = data.apps[0].goalTime
                if self.isNotHandleUsage {
                    self.screenTimeVM.handleStartDeviceActivityMonitoring(interval: self.appGoalTimeDouble)
                    self.isNotHandleUsage = false
                }
            }
        }
    }
    
    func convertMillisecondsToTimeInterval(milliseconds: Int) -> TimeInterval {
        return TimeInterval(milliseconds) / 1000.0
    }
    
    func convertMillisecondsToHMS(milliseconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        let secondsTotal = milliseconds / 1000
        let hours = secondsTotal / 3600
        let minutes = (secondsTotal % 3600) / 60
        let seconds = secondsTotal % 60
        return (hours, minutes, seconds)
    }

}
