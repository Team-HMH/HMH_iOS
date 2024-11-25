//
//  InfoPlist+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 11/20/24.
//

import Foundation
import ProjectDescription
import EnvPlugin

struct InfoPlistProvider {
    static func forApp(name: String) -> InfoPlist {
        var infoPlist = name.contains("Demo") ? Project.demoInfoPlist : Project.appInfoPlist
        
        switch name {
        case "DeviceActivityMonitor":
            infoPlist = Project.deviceActivityMonitorInfoPlist
        case "HMHDeviceActivityReport":
            infoPlist = Project.hmhDeviceActivityReportInfoPlist
        case "ShieldActionExtension":
            infoPlist = Project.shieldActionExtensionInfoPlist
        case "ShieldConfigureExtension":
            infoPlist = Project.shieldConfigureExtensionInfoPlist
        default:
            break
        }
        
        return .extendingDefault(with: infoPlist)
        
    }
}
