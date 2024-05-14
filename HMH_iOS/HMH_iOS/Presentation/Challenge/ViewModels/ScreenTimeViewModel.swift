//
//  ScreenTimeViewModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/10/24.
//

import SwiftUI

import FamilyControls
import ManagedSettings


class ScreenTimeViewModel: ObservableObject {
    let authorizationCenter = AuthorizationCenter.shared
    
    public init() {}
    
    @AppStorage("application", store: UserDefaults(suiteName: "group.HMH"))
    var selectionToDiscourage = FamilyActivitySelection()
    
    @AppStorage("permission", store: UserDefaults(suiteName: "group.HMH"))
    var hasScreenTimePermission: Bool = false {
        didSet {
            print("Changed: ", hasScreenTimePermission)
            updateHasScreenTimePermission()
        }
    }
    
    @Published
    var sharedHasScreenTimePermission = false
    
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
