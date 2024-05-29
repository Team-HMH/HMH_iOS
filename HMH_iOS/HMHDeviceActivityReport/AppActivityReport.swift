//
//  AppActivityReport.swift
//  HMHDeviceActivityReport
//
//  Created by 이지희 on 5/13/24.
//


import SwiftUI
import DeviceActivity

import RealmSwift

struct AppActivityReport: DeviceActivityReportScene {
    @AppStorage(AppStorageKey.appGoalTime.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var appGoalTimeDouble = 0
    
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
                        let appActivity = AppDeviceActivity(
                            id: bundle,
                            displayName: appName,
                            duration: duration,
                            numberOfPickups: numberOfPickups,
                            token: token
                        )
                        list.append(appActivity)
                    }
                }

            }
        }
        
        /// 필터링된 ActivityReport 데이터들을 반환
        return ActivityReport(totalDuration: totalActivityDuration, apps: list)
    }
}

struct ChallengeActivityReport: DeviceActivityReportScene {
    let context : DeviceActivityReport.Context = .challengeActivity
    let content: (ActivityReport) -> ChallengeActivityView
    
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
                        var id = 0
                        let appName = (applicationActivity.application.localizedDisplayName ?? "nil") /// 앱 이름
                        let bundle = (applicationActivity.application.bundleIdentifier ?? "nil") /// 앱 번들id
                        let duration = applicationActivity.totalActivityDuration /// 앱의 total activity 기간
                        totalActivityDuration += duration
                        let numberOfPickups = applicationActivity.numberOfPickups /// 앱에 대해 직접적인 pickup 횟수
                        let token = applicationActivity.application.token /// 앱의 토큰
                        let appActivity = AppDeviceActivity(
                            id: bundle,
                            displayName: appName,
                            duration: duration,
                            numberOfPickups: numberOfPickups,
                            token: token
                        )
                        let realmApp = Appdata(id: id)
                        realmApp.bundleId = bundle
                        realmApp.duraction = duration
                        
                        do {
                            let realm = try await Realm()
                            try realm.write {
                                realm.add(realmApp)
                            }
                        } catch {
                            print("Error initialising new realm \(error)")
                        }
                        list.append(appActivity)
                        id += 1
                    }
                }

            }
        }
        
        /// 필터링된 ActivityReport 데이터들을 반환
        return ActivityReport(totalDuration: totalActivityDuration, apps: list)
    }
}
