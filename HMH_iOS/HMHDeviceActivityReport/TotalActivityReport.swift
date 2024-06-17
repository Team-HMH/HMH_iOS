//
//  TotalActivityReport.swift
//  HMHDeviceActivityReport
//
//  Created by 이지희 on 4/15/24.
//

import DeviceActivity
import SwiftUI

extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
    static let totalActivity = Self("Total Activity")
    static let appActivity = Self("App Activity")
    static let challengeActivity = Self("Challenge Activity")
}

struct TotalActivityReport: DeviceActivityReportScene {
    @AppStorage(AppStorageKey.totalgoaltime.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var totalGoalTimeDouble = 0
    @AppStorage(AppStorageKey.usageGrade.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var usageGrade = ""
    @AppStorage(AppStorageKey.usageGrade.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var isFail: Bool = false

    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .totalActivity
    
    // Define the custom configuration and the resulting view for this report.
    let content: (TotalActivityModel) -> TotalActivityView
    
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> TotalActivityModel {
        // Reformat the data into a configuration that can be used to create
        // the report's view.
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        
        let time = formatter.string(from: totalActivityDuration) ?? "No activity data"
        
        let currentTimeInMilliseconds = convertTimeStringToMilliseconds(timeString: time)
        let remainingTimeInMilliseconds = max(totalGoalTimeDouble - currentTimeInMilliseconds, 0)
        
        let usagePercentage = min(Double(currentTimeInMilliseconds) / Double(totalGoalTimeDouble) * 100, 100)
        usageGrade = calculateGrade(usagePercentage)
        
        let totalActivity = TotalActivityModel.init(id: "totalActivity",
                                                    totalTime: currentTimeInMilliseconds,
                                                    remainTime: remainingTimeInMilliseconds,
                                                    totalGoalTime: totalGoalTimeDouble,
                                                    titleState: configHomeViewVisual())
        
        return totalActivity
    }
}

extension TotalActivityReport {
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
        if isFail {
            return "F"
        }
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
        
        if isFail {
            lottieTitle = "Main-F-final.json"
            titleString = StringLiteral.Home.usageStatusF
        }
        
        return [lottieTitle, titleString]
    }
    
    
}
