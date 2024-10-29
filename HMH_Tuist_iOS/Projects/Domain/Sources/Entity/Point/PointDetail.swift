//
//  PointDetail.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct PointDetail {
    let point: Int
    let period: Int
    let pointStatuses: [PointStatuse]
    
    public init(point: Int, period: Int, pointStatuses: [PointStatuse]) {
        self.point = point
        self.period = period
        self.pointStatuses = pointStatuses
    }
}

public struct PointStatuse {
    let date: String
    let status: String
    
    public init(date: String, status: String) {
        self.date = date
        self.status = status
    }
}
