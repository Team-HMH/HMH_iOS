//
//  PointService.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

typealias PointService = BaseService<PointAPI>

protocol PointServiceType {
    func getUsagePoint()
    func patchEarnPoint(challengeDate: String)
    func getEarnPoint()
    func getPointList()
    func patchPointUse(challengeDate: String)
}

extension PointService: PointServiceType {
    func getUsagePoint() {}
    func patchEarnPoint(challengeDate: String) {}
    func getEarnPoint() {}
    func getPointList() {}
    func patchPointUse(challengeDate: String) {}
    
}

struct StubPointServicee: PointServiceType {
    func getUsagePoint() {} 
    func patchEarnPoint(challengeDate: String) {}
    func getEarnPoint() {}
    func getPointList() {}
    func patchPointUse(challengeDate: String) {}
}

 
