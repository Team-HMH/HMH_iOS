//
//  KeyChainStorage.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/24/24.
//

import SwiftUI
import KeychainAccess

@propertyWrapper
struct KeychainStorage: DynamicProperty {
    // MARK: - Properties
    let keychainManager = Keychain()
    let key: String
    var wrappedValue: String {
        didSet {
            keychainManager[key] = wrappedValue
        }
    }
    // MARK: - Init
    init(wrappedValue: String = "", _ key: String) {
        self.key = key
        let initialValue = (keychainManager[key] ?? wrappedValue)
        self.wrappedValue = initialValue
    }
}
