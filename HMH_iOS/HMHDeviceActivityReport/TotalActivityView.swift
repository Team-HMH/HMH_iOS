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
        guard components.count == 3,
              let hours = Int(components[0].replacingOccurrences(of: "h", with: "")),
              let minutes = Int(components[1].replacingOccurrences(of: "m", with: "")),
              let seconds = Int(components[2].replacingOccurrences(of: "s", with: "")) else {
                  return nil
        }

        let hoursText = String(format: "%d", hours)
        let minutesText = String(format: "%d", minutes)
        
        return "\(hoursText)시간 \(minutesText)분"
    }
}

// In order to support previews for your extension's custom views, make sure its source files are
// members of your app's Xcode target as well as members of your extension's target. You can use
// Xcode's File Inspector to modify a file's Target Membership.
#Preview {
    TotalActivityView(totalActivity: "1h 23m")
}
