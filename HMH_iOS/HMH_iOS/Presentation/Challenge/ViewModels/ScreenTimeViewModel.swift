//
//  ScreenTimeViewModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/10/24.
//

import SwiftUI

import FamilyControls
import ManagedSettings
import DeviceActivity

@MainActor
final class ScreenTimeViewModel: ObservableObject {
    let authorizationCenter = AuthorizationCenter.shared
    let deviceActivityCenter = DeviceActivityCenter()
    let store = ManagedSettingsStore()
    
    @AppStorage(AppStorageKey.selectionApp.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var selectedApp = FamilyActivitySelection() {
        didSet {
            self.handleStartDeviceActivityMonitoring(interval: appGoalTimeDouble)
        }
    }
    
    @AppStorage(AppStorageKey.appGoalTime.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var appGoalTimeDouble = 0
    
    @AppStorage(AppStorageKey.permission.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var hasScreenTimePermission: Bool = false {
        didSet {
            print("Changed: ", hasScreenTimePermission)
            updateHasScreenTimePermission()
        }
    }
    
    @Published var sharedHasScreenTimePermission = false
    @Published var hashVaule: [String] = []
    
    
    func updateSelectedApp(newSelection: FamilyActivitySelection) {
        DispatchQueue.main.async {
            self.selectedApp = newSelection
        }
    }
    
    func requestAuthorization() {
        if authorizationCenter.authorizationStatus == .approved {
            print("approved")
        } else {
            Task {
                do {
                    try await authorizationCenter.requestAuthorization(for: .individual)
                    hasScreenTimePermission = true
                } catch {
                    //동의 X
                    print("Failed to enroll Aniyah with error: \(error)")
                    hasScreenTimePermission = false
                }
            }
        }
    }
    
    func updateHasScreenTimePermission() {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                self.sharedHasScreenTimePermission = self.hasScreenTimePermission
            }
        }
    }
    
    func handleTotalDeviceActivityMonitoring(includeUsageThreshold: Bool = true, interval: Int) {
        //datacomponent타입을 써야함
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())
        
        // 새 스케쥴 시간 설정
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: dateComponents.hour, minute: dateComponents.minute, second: dateComponents.second),
            intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
            repeats: false,
            //warning Time 설정해야 알람
            warningTime: DateComponents(minute: interval - 1 ) // 여기는 전체 시간 가까워질 때
        )
         //새 이벤트 생성
        let totalEvent = DeviceActivityEvent(threshold: DateComponents(minute: interval))
        
        do {
            deviceActivityCenter.stopMonitoring()
            try deviceActivityCenter.startMonitoring(
                .total,
                during: schedule,
                events: [.monitoring: totalEvent]
            )
            print("Start Total Monitoring")
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
    func handleStartDeviceActivityMonitoring(includeUsageThreshold: Bool = true, interval: Int) {
        //datacomponent타입을 써야함
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())
        let minute: Int = interval / 60000
        
        // 새 스케쥴 시간 설정
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: dateComponents.hour, minute: dateComponents.minute, second: dateComponents.second),
            intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
            repeats: false,
            //warning Time 설정해야 알람
            warningTime: DateComponents(minute: minute - 1 ) // 여기는 전체 시간 가까워질 때
        )
         //새 이벤트 생성
        let event = DeviceActivityEvent(
            applications: selectedApp.applicationTokens,
            categories: selectedApp.categoryTokens,
            webDomains: selectedApp.webDomainTokens,
            //threshold - 이 시간이 되면 특정한 event가 발생 deviceactivitymonitor에 eventdidreachthreshold
            threshold: DateComponents(minute : minute)
            )
        
        do {
            deviceActivityCenter.stopMonitoring()
            try deviceActivityCenter.startMonitoring(
                .once,
                during: schedule,
                events: [.monitoring: event]
            )
            print("Start Each App Monitoring : \(minute)")
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
    func handleSetBlockApplication() {
        store.shield.applications = selectedApp.applicationTokens.isEmpty ? nil : selectedApp.applicationTokens
        store.shield.applicationCategories = selectedApp.categoryTokens.isEmpty ? nil
        : ShieldSettings.ActivityCategoryPolicy.specific(selectedApp.categoryTokens)
    }
    
    func stopDeviceMonitoring(){
        deviceActivityCenter.stopMonitoring()
    }
    
    func block(completion: @escaping (Result<Void, Error>) -> Void) {
        let blockSchedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            repeats: false,
            warningTime: DateComponents(minute: 10)
        )
        
        store.shield.applications = selectedApp.applicationTokens
        do {
            try deviceActivityCenter.startMonitoring(DeviceActivityName.once,
                                                     during: blockSchedule)
        } catch {
            completion(.failure(error))
            return
        }
        completion(.success(()))
    }
    
    func unblockApp(app: ApplicationToken) {
        store.shield.applications?.remove(app)
    }
    
    func unblockAllApps() {
        store.shield.applications = []
    }
}


extension FamilyActivitySelection: RawRepresentable {
    func jsonString() -> String? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            guard let jsonString = String(data: data, encoding: .utf8) else {
                print("Error encoding FamilyActivitySelection")
                return nil
            }
            return jsonString
        } catch {
            print("Error encoding FamilyActivitySelection: \(error)")
            return nil
        }
    }
    
    static func from(jsonString: String) -> FamilyActivitySelection? {
        guard let data = jsonString.data(using: .utf8) else {
            print("Error converting string to Data")
            return nil
        }
        
        let decoder = JSONDecoder()
        do {
            let familyActivitySelection = try decoder.decode(FamilyActivitySelection.self, from: data)
            return familyActivitySelection
        } catch {
            print("Error decoding FamilyActivitySelection: \(error)")
            return nil
        }
    }
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data)
        else {
            return nil
        }
        self = result
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

struct AppDeviceActivity: Identifiable {
    var id: String
    var displayName: String
    var token: ApplicationToken
}

extension DeviceActivityName {
    static let once = Self("once")
    static let total = Self("total")
}

extension DeviceActivityEvent.Name {
    static let monitoring = Self("monitoring")
}
