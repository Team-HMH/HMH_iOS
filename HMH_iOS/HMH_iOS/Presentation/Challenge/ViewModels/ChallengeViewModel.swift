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
    
    enum PointStatus {
        static let unearned = "UNEARNED"
        static let earned = "EARNED"
        static let failure = "FAILURE"
    }
    
    init() {
        getChallengeInfo()
    }
    
    func getChallengeType() {
        if days <= 0 {
            challengeType = .empty
        } else if 14 <= days {
            challengeType = .large
        } else {
            challengeType = .normal
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
            print(self.days)
            self.getChallengeType()
        }
    }
    
    func createChallenge(bundle: [String]) {
        
        let dto = CreateChallengeRequestDTO(period: 7, goalTime: 1204928)
        Providers.challengeProvider.request(target: .createChallenge(data: dto), instance: BaseResponse<EmptyResponseDTO>.self) { result in
            print(result)
        }
        var applist: [Apps] = []
        
        bundle.forEach { bundleid in
            applist.append(Apps(appCode: bundleid, goalTime: 10000000))
        }
        
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
