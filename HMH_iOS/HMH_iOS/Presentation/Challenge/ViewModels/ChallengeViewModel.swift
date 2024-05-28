//
//  ChallengeViewModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/7/24.
//

import SwiftUI
import FamilyControls

final class ChallengeViewModel: ObservableObject {
    @Published var startDate = ""
    @Published var todayIndex = 0
    @Published var days = 7
    @Published var appList: [Apps] = []
    @Published var challengeStatus: [String] = []
    
    @Published var titleString = ""
    @Published var subTitleString = ""
    
    enum PointStatus {
        static let unearned = "UNEARNED"
        static let earned = "EARNED"
        static let failure = "FAILURE"
    }
    
    init() {
        getChallengeInfo()
    }
    
    func checkPointStatus(status: String) -> Image{
        switch status {
        case PointStatus.unearned:
            return Image(.beforeTake)
        case PointStatus.failure:
            return Image(.failRound)
        case PointStatus.earned:
            return Image(.doneRound)
        default:
            return Image(.doneRound)
        }
    }
    
    func isEmptyChallenge() -> Bool {
        if days > 0 {
            return false
        } else {
            return true
        }
    }
    
    func getChallengeInfo() {
        Providers.challengeProvider.request(target: .getChallenge,
                                            instance: BaseResponse<GetChallengeResponseDTO>.self) { result in
            guard let data = result.data else { return }
            self.days = data.period
            self.appList = data.apps
            self.challengeStatus = data.statuses
            self.startDate = self.formatDateString(data.startDate) ?? ""
            self.todayIndex = data.todayIndex
            
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
