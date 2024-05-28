//
//  ChallengeViewModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/7/24.
//

import SwiftUI
import FamilyControls

final class ChallengeViewModel: ObservableObject {
    @Published var startDate = "5월 5일"
    @Published var days = -1
    @Published var appList: [Apps] = []
    
    @Published var createChallengeState = 1 {
        didSet {
            setTitle()
        }
    }
    @Published var titleString = ""
    @Published var subTitleString = ""
    
    init() {
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
    
    func setTitle(){
        switch createChallengeState {
        case 1:
            titleString = "ddd"
            subTitleString = "ddd"
        case 2:
            titleString = "ddd"
            subTitleString = "ddd"
        default:
            print("state invaild")
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
