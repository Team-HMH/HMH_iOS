//
//  PointDTO.swift
//  Networks
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct PointResult: Decodable {
    public let point: Int
}

extension PointResult {
    static var stub: Self {
        .init(point: 1000)
    }
}
