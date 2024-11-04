//
//  PointListResponseDTO.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/30/24.
//

import Foundation

public struct PointListResult: Decodable {
    public let point: Int
    public let period: Int
    public let challengePointStatuses: [ChallengePointStatuses]
}

public struct ChallengePointStatuses: Decodable {
    public let challengeDate: String
    public let status: String
}

public extension PointListResult {
    static var stub: Self {
        return .init(point: 100, period: 100, challengePointStatuses: [.stub, .stub, .stub])
    }
}

public extension ChallengePointStatuses {
    static var stub: Self {
        return .init(challengeDate: "Asdfasdfasdfas", status: "ASdfasdfasdfas")
    }
}
