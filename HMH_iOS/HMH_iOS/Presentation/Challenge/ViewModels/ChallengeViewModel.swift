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
    @Published var visableStartDate = ""
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
            self.startDate = data.startDate
            self.visableStartDate = self.formatDateString(data.startDate) ?? ""
            
            self.sendSucessIfNeeded()
            self.getChallengeType()
        }
    }
    
    func challengeButtonTapped() {
        if remainEarnPoint == 0 {
            navigateToCreate = true
        } else {
            isToastPresented = true
        }
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
        let midnightDTO = MidnightRequestDTO(finishedDailyChallenges: [FinishedDailyChallenge(challengeDate: date, isSuccess: false)])
        Providers.challengeProvider.request(target: .postDailyChallenge(data: midnightDTO), instance: BaseResponse<EmptyResponseDTO>.self) { result in
            print("Daily challenge data sent successfully.")
        }
    }
    
    func sendSucessIfNeeded() {
        let noneDates = findNoneDates(statuses: statuses, todayIndex: todayIndex, startDate: startDate)
        var finishChallenges: [FinishedDailyChallenge] = []
        
        noneDates.forEach { date in
            finishChallenges.append(FinishedDailyChallenge(challengeDate: date, isSuccess: true))
        }
        
        if !(finishChallenges.isEmpty) {
            let finishDateDTO = MidnightRequestDTO(finishedDailyChallenges: finishChallenges)
            
            Providers.challengeProvider.request(target: .postDailyChallenge(data: finishDateDTO), instance: BaseResponse<EmptyResponseDTO>.self) { result in
                print("Daily challenge data sent successfully.")
            }
        }
    }
    
    func findNoneDates(statuses: [String], todayIndex: Int, startDate: String) -> [String] {
        var dates: [String] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let start = dateFormatter.date(from: startDate) else {
            print("Invalid start date format")
            return dates
        }
        
        let calendar = Calendar.current
        if todayIndex > 0 {
            for index in 0..<todayIndex {
                if statuses[index] == "NONE" {
                    if let newDate = calendar.date(byAdding: .day, value: index, to: start) {
                        let formattedDate = dateFormatter.string(from: newDate)
                        dates.append(formattedDate)
                    }
                }
            }
        } else {
            for index in 0..<days {
                if statuses[index] == "NONE" {
                    if let newDate = calendar.date(byAdding: .day, value: index, to: start) {
                        let formattedDate = dateFormatter.string(from: newDate)
                        dates.append(formattedDate)
                    }
                }
            }
        }
        
        return dates
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
