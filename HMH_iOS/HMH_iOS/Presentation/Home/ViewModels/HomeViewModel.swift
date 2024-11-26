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
import Amplitude

class HomeViewModel: ObservableObject {
    @AppStorage(AppStorageKey.totalGoalTime.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var totalGoalTimeDouble = 0
    @AppStorage(AppStorageKey.appGoalTime.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var appGoalTimeDouble = 0
    @AppStorage(AppStorageKey.usageGrade.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var usageGrade = ""
    
    @AppStorage("handleUsage") var isNotHandleUsage: Bool = true
    @ObservedObject var screenTimeVM = ScreenTimeViewModel()
    @Published var homeBanner = homeBannerModel(title: "", subTitle: "", imageUrl: "", linkUrl: "", backgroundColors: [])
    
    init(){    }
    
    func getDailyChallenge() {
        Providers.challengeProvider.request(target: .getdailyChallenge, instance: BaseResponse<HomeChallengeResponseDTO>.self) { result in
            if let data = result.data {
                self.totalGoalTimeDouble = data.goalTime
                self.screenTimeVM.handleTotalDeviceActivityMonitoring(interval: self.totalGoalTimeDouble/60000)
                if self.isNotHandleUsage {
                    self.screenTimeVM.handleStartDeviceActivityMonitoring(interval: self.appGoalTimeDouble)
                    self.isNotHandleUsage = false
                }
            }
        }
    }
    
    func getBannerInfo() {
        Providers.bannerProvider.request(target: .getBannerInfo, instance: BaseResponse<BannerResponseDTO>.self) { result in
            if let data = result.data {
                self.homeBanner = homeBannerModel(
                    title: data.title,
                    subTitle: data.subTitle,
                    imageUrl: data.imageUrl,
                    linkUrl: data.linkUrl,
                    backgroundColors: data.backgroundColors.map{ Color(hex: $0) }
                )
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

    func addButtonClicked() {
        Amplitude.instance().logEvent("click_add_button")
    }
    
    func editButtonClicked() {
        Amplitude.instance().logEvent("click_edit_button")
    }
}
