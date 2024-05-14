//
//  TotalActivityView.swift
//  HMHDeviceActivityReport
//
//  Created by 이지희 on 4/15/24.
//

import SwiftUI

struct TotalActivityView: View {
    let totalActivity: String
    
    var body: some View {
        if let timeString = convertStringToTime(totalActivity) {
            Text("\(timeString) 사용")
                .font(.title2_semibold_24)
                .foregroundStyle(.whiteText)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

extension TotalActivityView {
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
}


// In order to support previews for your extension's custom views, make sure its source files are
// members of your app's Xcode target as well as members of your extension's target. You can use
// Xcode's File Inspector to modify a file's Target Membership.
//#Preview {
//    TotalActivityView(totalActivity: "1h 23m")
//}
