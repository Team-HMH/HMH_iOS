//
//  UserDefaultsManager.swift
//  HMH_iOS
//
//  Created by 이지희 on 6/17/24.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let lastSentDate = "lastSentDate"
    }

    var lastSentDate: String? {
        get {
            return string(forKey: Keys.lastSentDate)
        }
        set {
            set(newValue, forKey: Keys.lastSentDate)
        }
    }
}
