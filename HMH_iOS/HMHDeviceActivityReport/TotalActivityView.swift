//
//  TotalActivityView.swift
//  HMHDeviceActivityReport
//
//  Created by 이지희 on 4/15/24.
//

import SwiftUI

struct TotalActivityView: View {
    
    let totalActivity: TotalActivityModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("목표 사용 시간 \(convertMillisecondsToHourString(milliseconds: totalActivity.totalGoalTime)) 중")
                .font(.detail4_medium_12)
                .foregroundStyle(.gray2)
                .frame(alignment: .leading)
                .padding(EdgeInsets(top: 0,
                                    leading: 20,
                                    bottom: 0,
                                    trailing: 0))
            HStack {
                Text("\(convertMillisecondsToHourString(milliseconds: totalActivity.totalTime)) 사용")
                    .font(.title2_semibold_24)
                    .foregroundStyle(.whiteText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text(convertMillisecondsToHourString(milliseconds: totalActivity.remainTime) + " 남음")
                    .font(.detail3_semibold_12)
                    .foregroundStyle(.whiteText)
            }
            . padding(EdgeInsets(top: 2,
                                 leading: 20,
                                 bottom: 24,
                                 trailing: 20))
            ProgressView(value: Double(totalActivity.totalTime), total: Double(totalActivity.totalGoalTime))
                .foregroundStyle(.gray5)
                .padding(EdgeInsets(top: 0,
                                    leading: 20,
                                    bottom: 0,
                                    trailing: 20))
                .tint(.whiteText)
        }
    }
}

extension TotalActivityView {
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
    
}

// In order to support previews for your extension's custom views, make sure its source files are
// members of your app's Xcode target as well as members of your extension's target. You can use
// Xcode's File Inspector to modify a file's Target Membership.
//#Preview {
//    TotalActivityView(totalActivity: "1h 23m")
//}
