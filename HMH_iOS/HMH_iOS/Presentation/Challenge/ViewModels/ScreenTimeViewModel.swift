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
    static let shared = ScreenTimeViewModel()
    
    private init() {}
    
    @AppStorage("application", store: UserDefaults(suiteName: "group.HMH"))
    var selectionToDiscourage = FamilyActivitySelection()
    var application: AppDeviceActivity?
    
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
