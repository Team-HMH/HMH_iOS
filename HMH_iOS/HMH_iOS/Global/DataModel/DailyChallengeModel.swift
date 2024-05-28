//
//  DailyChallengeModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/26/24.
//

import Foundation

import RealmSwift

class Appdata: Object {
    @Persisted var number: Int?
    @Persisted var bundleId: String = ""
    @Persisted var duraction: Double = 0

    convenience init(id: Int) {
        self.init()
        self.number = id
    }
}


class TotalTime: Object {
    @Persisted var duraction: String = ""
}
