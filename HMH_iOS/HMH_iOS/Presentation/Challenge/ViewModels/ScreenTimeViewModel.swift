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


final class ScreenTimeViewModel: ObservableObject {
    let authorizationCenter = AuthorizationCenter.shared
    let deviceActivityCenter = DeviceActivityCenter()
    let store = ManagedSettingsStore()
    
    @AppStorage(AppStorageKey.selectionApp.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var selectedApp = FamilyActivitySelection()
    
    @AppStorage(AppStorageKey.permission.rawValue, store: UserDefaults(suiteName: APP_GROUP_NAME))
    var hasScreenTimePermission: Bool = false {
        didSet {
            print("Changed: ", hasScreenTimePermission)
            updateHasScreenTimePermission()
        }
    }
    
    @Published var sharedHasScreenTimePermission = false
    var hashVaule: [Int] = []
    
    @MainActor func updateSelectedApp(newSelection: FamilyActivitySelection) {
        DispatchQueue.main.async {
            self.selectedApp = newSelection
        }
    }
    
    func saveHashValue() {
        selectedApp.applicationTokens.forEach { app in
            hashVaule.append(app.hashValue)
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
    
    func handleStartDeviceActivityMonitoring(includeUsageThreshold: Bool = true, interval: Int) {
        //datacomponent타입을 써야함
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())
        
        // 새 스케쥴 시간 설정
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: dateComponents.hour, minute: dateComponents.minute, second: dateComponents.second),
            intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
            repeats: false,
            //warning Time 설정해야 알람
            warningTime: DateComponents(minute: 1)
        )
         //새 이벤트 생성
        let event = DeviceActivityEvent(
            applications: selectedApp.applicationTokens,
            categories: selectedApp.categoryTokens,
            webDomains: selectedApp.webDomainTokens,
            //threshold - 이 시간이 되면 특정한 event가 발생 deviceactivitymonitor에 eventdidreachthreshold
            threshold: DateComponents(minute : interval)
            )
        
        do {
            deviceActivityCenter.stopMonitoring()
            try deviceActivityCenter.startMonitoring(
                .once,
                during: schedule,
                events: [.monitoring: event]
            )
            print("📺📺모니터링 시작📺📺")
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
            print("여기 들어오나?")
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
}

extension DeviceActivityEvent.Name {
    static let monitoring = Self("monitoring")
}
