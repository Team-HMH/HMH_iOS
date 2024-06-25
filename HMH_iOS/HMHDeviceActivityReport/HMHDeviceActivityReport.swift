//
//  HMHDeviceActivityReport.swift
//  HMHDeviceActivityReport
//
//  Created by 이지희 on 4/15/24.
//

import DeviceActivity
import SwiftUI

@main
struct HMHDeviceActivityReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        AppActivityReport { appActivity in
            AppActivityView(activityReport: appActivity)
        }
        ChallengeActivityReport { appActivity in
            ChallengeActivityView(activityReport: appActivity)
        }
        // Add more reports here...
    }
}
