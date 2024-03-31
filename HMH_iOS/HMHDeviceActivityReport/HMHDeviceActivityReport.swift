//
//  HMHDeviceActivityReport.swift
//  HMHDeviceActivityReport
//
//  Created by 이지희 on 3/31/24.
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
        // Add more reports here...
    }
}
