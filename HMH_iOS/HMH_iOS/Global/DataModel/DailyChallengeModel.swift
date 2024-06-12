//
//  DailyChallengeModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/26/24.
//

import Foundation

import RealmSwift

class MidnightData: Object {
    @objc dynamic var challengeDate: String = Date().toString()
    @objc dynamic var isSuccess: Bool = true

    override static func primaryKey() -> String? {
        return "challengeDate"
    }
}
