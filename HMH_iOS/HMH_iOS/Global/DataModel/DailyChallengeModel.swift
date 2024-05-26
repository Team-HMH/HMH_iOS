//
//  DailyChallengeModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/26/24.
//

import Foundation

import RealmSwift

final class DailyChallengeModel: Object {
    
    @objc dynamic var id = "" // 기본키
    @objc dynamic var date = Date()
    @objc dynamic var is_send: Bool = false
    @objc dynamic var apps: [AppData] = []
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class AppData: Object {
    @objc dynamic var id = "" // 기본키
    @objc dynamic var appCode: String = ""
    @objc dynamic var appUsageTime: Double = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
