//
//  CreateChallengeRequestDTO.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/12/24.
//

import Foundation

public struct CreateChallengeRequest: Encodable {
    let period: Int
    let goalTime: Int
    
    public init(period: Int, goalTime: Int) {
        self.period = period
        self.goalTime = goalTime
    }
}

public extension CreateChallengeRequest {
    static var stub: Self {
        .init(period: 1, goalTime: 1)
    }
}
