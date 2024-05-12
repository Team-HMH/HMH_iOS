//
//  ChallengeViewModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/7/24.
//

import SwiftUI
import FamilyControls

class ChallengeViewModel: ObservableObject {
    @Published var startDate = "5월 5일"
    @Published var days = 1
    @Published var appList: [String] = ["dd", "dd", "ddd"]
    @Published var data: ChallengeDTO? // 더미 데이터
    
    init() {
        generateDummyData()
    }
    
    // 더미 데이터를 생성하는 함수
    func generateDummyData() {
        // JSON 데이터를 파싱하여 더미 데이터 생성
        let jsonString = """
        {
            "period": 7,
            "statuses": ["UNEARNED", "UNEARNED"],
            "todayIndex": 2,
            "goalTime": 7200000,
            "apps": [
                { "appCode": "#292043", "goalTime": 12312420 },
                { "appCode": "#693043", "goalTime": 12312420 }
            ]
        }
        """
        
        // JSON 데이터를 DataClass로 파싱
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let decoder = JSONDecoder()
                self.data = try decoder.decode(ChallengeDTO.self, from: jsonData)
            } catch {
                print("JSON 데이터 파싱 실패:", error)
            }
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
