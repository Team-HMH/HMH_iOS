//
//  PointDetail.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct PointDetail: Equatable {
    let point: Int
    let period: Int
    let pointStatuses: [PointStatuse]
    
    public init(point: Int, period: Int, pointStatuses: [PointStatuse]) {
        self.point = point
        self.period = period
        self.pointStatuses = pointStatuses
    }
}

public struct PointStatuse: Equatable {
    let date: String
    let status: String
    
    public init(date: String, status: String) {
        self.date = date
        self.status = status
    }
}

public extension PointStatuse {
    static var stub: Self {
        return .init(date: "Asdfasdfasdfas", status: "ASdfasdfasdfas")
    }
}
