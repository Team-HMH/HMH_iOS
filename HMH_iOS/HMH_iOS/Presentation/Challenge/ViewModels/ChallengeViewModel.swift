//
//  ChallengeViewModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/7/24.
//

import SwiftUI
import FamilyControls

enum ChallengeType {
    case empty
    case normal
    case large
}

final class ChallengeViewModel: ObservableObject {
    @Published var startDate = ""
    @Published var todayIndex = 0
    @Published var days = 7
    @Published var appList: [Apps] = []
    @Published var statuses: [String] = []
    @Published var titleString = ""
    @Published var subTitleString = ""
    @Published var challengeType: ChallengeType = .empty
    @Published var remainEarnPoint = 0
    @Published var navigateToCreate = false
    @Published var isToastPresented = false
    
    @StateObject var screenViewModel = ScreenTimeViewModel()
    
    enum PointStatus {
        static let unearned = "UNEARNED"
        static let earned = "EARNED"
        static let failure = "FAILURE"
    }
    
    init() {
        getChallengeInfo()
    }
    
    func getChallengeType() {
        if todayIndex < 0 {
            challengeType = .empty
        } else if 14 < days {
            challengeType = .large
        } else {
            challengeType = .normal
        }
    }
    
    func getEarnPoint() {
        Providers.pointProvider.request(target: .getEarnPoint,
                                        instance: BaseResponse<GetEarnPointResponseDTO>.self) { result in
            guard let data = result.data else { return }
            self.remainEarnPoint = data.earnPoint
        }
    }
    
    
    func getChallengeInfo() {
        Providers.challengeProvider.request(target: .getChallenge,
                                            instance: BaseResponse<GetChallengeResponseDTO>.self) { result in
            guard let data = result.data else { return }
            self.days = data.period
            self.appList = data.apps
            self.statuses = data.statuses
            self.todayIndex = data.todayIndex
            self.startDate = self.formatDateString(data.startDate) ?? ""
            
            print(self.days)
            self.getChallengeType()
        }
    }
    
    func challengeButtonTapped() {
        if remainEarnPoint == 0 {
            navigateToCreate = true
        } else {
            isToastPresented = true
        }
        // 토스트 여부 처리
    }
    
    func addApp(appGoalTime: Int) {
        var applist: [Apps] = []
        
        screenViewModel.selectedApp.applications.forEach { app in
            applist.append(Apps(appCode: app.localizedDisplayName ?? "basic name", goalTime: appGoalTime))
        }
        
        screenViewModel.handleStartDeviceActivityMonitoring(includeUsageThreshold: true, interval: appGoalTime)
        
        Providers.challengeProvider.request(target: .addApp(data: AddAppRequestDTO(apps: applist)), instance: BaseResponse<EmptyResponseDTO>.self) { result in
            print(result)
        }
        
    }
    
    func formatDateString(_ dateString: String) -> String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = inputDateFormatter.date(from: dateString) else {
            return nil
        }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "M월 d일"
        let formattedDateString = outputDateFormatter.string(from: date)
        
        return formattedDateString
    }
    
    func sendFailChallenge(date: String) {
        let midnightDTO = MidnightRequestDTO(finishedDailyChallenges: [FinishedDailyChallenge(challengeDate: date,
                                                                                              isSuccess: false)])

        Providers.challengeProvider.request(target: .postDailyChallenge(data: midnightDTO), instance: BaseResponse<EmptyResponseDTO>.self) { result in
                print("Daily challenge data sent successfully.")
        }
    }
    
}

struct ChallengeDTO: Codable {
    let period: Int
    let statuses: [String]
    let todayIndex: Int
    let goalTime: Int
    let apps: [AppInfo]
}

// MARK: - App
struct AppInfo: Codable {
    let appCode: String
    let goalTime: Int
}
