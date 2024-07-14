//
//  PointListResponseDTO.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/30/24.
//

import Foundation

struct PointListResponseDTO: Codable {
    let point: Int
    let period: Int
    let challengePointStatuses: [PointList]
}

struct PointList: Codable {
    let challengeDate: String
    let status: String
}
