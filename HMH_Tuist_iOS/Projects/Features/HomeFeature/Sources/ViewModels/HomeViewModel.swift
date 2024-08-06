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

import Core

class HomeViewModel: ObservableObject {
    @AppStorage(AppStorageKey.totalGoalTime.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var totalGoalTimeDouble = 0
    @AppStorage(AppStorageKey.appGoalTime.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var appGoalTimeDouble = 0
    @AppStorage(AppStorageKey.usageGrade.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var usageGrade = ""
    
    @AppStorage("handleUsage") var isNotHandleUsage: Bool = true
    
    //TODO: 말썽꾸러기 스크린뷰모델
//    @StateObject var screenTimeVM = ScreenTimeViewModel()
    
    init(){
        getDailyChallenge()
    }
    
    //TODO: 네트워크 부분은 의존성 정리한 뒤에 다시 연결해봅시다
    func getDailyChallenge() {
//        Providers.challengeProvider.request(target: .getdailyChallenge, instance: BaseResponse<HomeChallengeResponseDTO>.self) { result in
//            if let data = result.data {
//                self.totalGoalTimeDouble = data.goalTime
//                self.appGoalTimeDouble = data.apps[0].goalTime
//                if self.isNotHandleUsage {
//                    self.screenTimeVM.handleStartDeviceActivityMonitoring(interval: self.appGoalTimeDouble)
//                    self.screenTimeVM.handleTotalDeviceActivityMonitoring(interval: self.totalGoalTimeDouble/60000)
//                    self.isNotHandleUsage = false
//                }
//            }
//        }
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
