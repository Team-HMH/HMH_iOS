//
//  HomeDeviceActivityReportScene.swift
//  HMHDeviceActivityReport
//
//  Created by 이지희 on 6/21/24.
//

import SwiftUI
import DeviceActivity

struct AppActivityReport: DeviceActivityReportScene {
    @AppStorage(AppStorageKey.appGoalTime.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var appGoalTimeDouble = 0
    @AppStorage(AppStorageKey.totalGoalTime.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var userTotalGoalTime = 0
    @AppStorage(AppStorageKey.usageGrade.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var usageGrade = ""
    @AppStorage(AppStorageKey.usageGrade.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var isFail: Bool = false
    
    @ObservedObject var screenTimeViewModel = ScreenTimeViewModel()
    let context : DeviceActivityReport.Context = .appActivity
    let content: (ActivityReport) -> AppActivityView
    
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> ActivityReport {
        
        var totalActivityDuration: Double = 0
        var list: [AppDeviceActivity] = []
        
        /// DeviceActivityResults 데이터에서 화면에 보여주기 위해 필요한 내용을 추출해줍니다.
        for await eachData in data {
            /// 특정 시간 간격 동안 사용자의 활동
            for await activitySegment in eachData.activitySegments {
                /// 활동 세그먼트 동안 사용자의 카테고리 별 Device Activity
                for await categoryActivity in activitySegment.categories {
                    /// 이 카테고리의 totalActivityDuration에 기여한 사용자의 application Activity
                    for await applicationActivity in categoryActivity.applications {
                        let appName = (applicationActivity.application.localizedDisplayName ?? "nil") /// 앱 이름
                        let bundle = (applicationActivity.application.bundleIdentifier ?? "nil") /// 앱 번들id
                        let duration = applicationActivity.totalActivityDuration /// 앱의 total activity 기간
                        totalActivityDuration += duration
                        let numberOfPickups = applicationActivity.numberOfPickups /// 앱에 대해 직접적인 pickup 횟수
                        let token = applicationActivity.application.token /// 앱의 토큰
                        let goalTimeInSeconds: TimeInterval = TimeInterval(appGoalTimeDouble / 1000)
                        let remainingTime = max(goalTimeInSeconds - duration, 0) /// 남은 시간 계산
                        let appActivity = AppDeviceActivity(
                            id: bundle,
                            displayName: appName,
                            duration: duration,
                            remainTime: remainingTime,
                            numberOfPickups: numberOfPickups,
                            token: token
                        )
                        list.append(appActivity)
                    }
                }
                
            }
        }
        
        /// 선택 앱 시간의 합으로
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        
        let currentTimeInMilliseconds = Int(totalActivityDuration * 1000)
        let remainingTimeInMilliseconds = userTotalGoalTime - Int(currentTimeInMilliseconds)
        
        let usagePercentage = min(Double(currentTimeInMilliseconds) / Double(userTotalGoalTime) * 100, 100)
        usageGrade = calculateGrade(usagePercentage)
        
        /// 필터링된 ActivityReport 데이터들을 반환
        return ActivityReport(totalDuration: currentTimeInMilliseconds,
                              titleState: configHomeViewVisual(),
                              remainTime: remainingTimeInMilliseconds,
                              totalGoalTime: userTotalGoalTime,
                              apps: list)
    }
}

extension AppActivityReport {
    
    func convertStringToTime(_ string: String) -> String? {
        let components = string.components(separatedBy: " ")
        
        // "시간"과 "분"을 분리하여 처리
        var hours = 0
        var minutes = 0
        
        // 각 구성요소를 확인하고, 해당하는 값이 있으면 설정
        for component in components {
            if component.contains("h") {
                if let hourValue = Int(component.replacingOccurrences(of: "h", with: "")) {
                    hours = hourValue
                }
            } else if component.contains("m") {
                if let minuteValue = Int(component.replacingOccurrences(of: "m", with: "")) {
                    minutes = minuteValue
                }
            }
        }
        
        // 반환 문자열 생성
        if hours > 0 && minutes > 0 {
            return "\(hours)시간 \(minutes)분"
        } else if hours > 0 {
            return "\(hours)시간"
        } else if minutes > 0 {
            return "\(minutes)분"
        } else {
            // "시간"이나 "분"이 없는 경우
            return nil
        }
    }
    
    func convertMillisecondsToHourString(milliseconds: Int) -> String {
        let secondsTotal = milliseconds / 1000
        let hours = secondsTotal / 3600
        let minutes = (secondsTotal % 3600) / 60
        
        if hours > 0 {
            if minutes > 0 {
                return "\(hours)시간 \(minutes)분"
            } else {
                return "\(hours)시간"
            }
        } else {
            return "\(minutes)분"
        }
    }

    
    func convertTimeStringToMilliseconds(timeString: String) -> Int {
        let regex = try! NSRegularExpression(pattern: "(?:(\\d+)h)?\\s*(?:(\\d+)m)?")
        guard let match = regex.firstMatch(in: timeString, range: NSRange(timeString.startIndex..., in: timeString)) else {
            return 0
        }
        
        var hours = 0
        var minutes = 0
        
        if let hourRange = Range(match.range(at: 1), in: timeString) {
            hours = Int(timeString[hourRange]) ?? 0
        }
        
        if let minuteRange = Range(match.range(at: 2), in: timeString) {
            minutes = Int(timeString[minuteRange]) ?? 0
        }
        
        let totalMilliseconds = (hours * 3600 + minutes * 60) * 1000
        return totalMilliseconds
    }

    private func calculateGrade(_ usagePercentage: Double) -> String {
//        if isFail {
//            return "F"
//        }
        switch usagePercentage {
        case 0..<25:
            return "A"
        case 25..<50:
            return "B"
        case 50..<75:
            return "C"
        case 75..<100:
            return "D"
        case 100:
            return "E"
        default:
            return "F"
        }
    }
    
    func configHomeViewVisual() -> [String] {
        var lottieTitle = "Main-\(usageGrade)-final.json"
        
        var titleString = ""

        switch usageGrade{
        case "A":
            lottieTitle = "Main-A-final.json"
            titleString = StringLiteral.Home.usageStatusA
        case "B":
            lottieTitle = "Main-B-final.json"
            titleString = StringLiteral.Home.usageStatusB
        case "C":
            lottieTitle = "Main-C-final.json"
            titleString = StringLiteral.Home.usageStatusC
        case "D":
            lottieTitle = "Main-D-final.json"
            titleString = StringLiteral.Home.usageStatusD
        case "E":
            lottieTitle = "Main-E-final.json"
            titleString = StringLiteral.Home.usageStatusE
        case "F":
            lottieTitle = "Main-F-final.json"
            titleString = StringLiteral.Home.usageStatusF
        default:
            titleString = ""
        }
        
//        if isFail {
//            lottieTitle = "Main-F-final.json"
//            titleString = StringLiteral.Home.usageStatusF
//        }
//        
        return [lottieTitle, titleString]
    }
    
    
}
