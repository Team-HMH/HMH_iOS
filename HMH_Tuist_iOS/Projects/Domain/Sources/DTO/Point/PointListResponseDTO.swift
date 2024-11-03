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

struct PointList: Codable, Hashable {
    let challengeDate: String
    let status: String
}

// 여기서부터는 이제 다른 모듈


