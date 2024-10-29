//
//  PointListResponseDTO.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/30/24.
//

import Foundation

public struct PointListResult: Decodable {
    let point: Int
    let period: Int
    let challengePointStatuses: [PointList]
}

public struct PointList: Decodable {
    let challengeDate: String
    let status: String
}

public extension PointListResult {
    static var stub: Self {
        return .init(point: 100, period: 100, challengePointStatuses: [.stub, .stub, .stub])
    }
}

public extension PointList {
    static var stub: Self {
        return .init(challengeDate: "Asdfasdfasdfas", status: "ASdfasdfasdfas")
    }
}
