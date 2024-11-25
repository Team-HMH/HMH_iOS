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
    
    public func getPoint() -> Int {
        return point
    }
    
    public func getPeriod() -> Int {
        return period
    }
    
    public func getPointStatuses() -> [PointStatuse] {
        return pointStatuses
    }
}

public struct PointStatuse: Equatable {
    let date: String
    let status: PointStatusEnum
    
    public init(date: String, status: String) {
        self.date = date
        self.status = PointStatusEnum(rawValue: status) ?? .none
    }
    
    public func getDate() -> String {
        return date
    }
    
    public func getStatus() -> PointStatusEnum {
        return status
    }
}

public extension PointStatuse {
    static var stub: Self {
        return .init(date: "Asdfasdfasdfas", status: "ASdfasdfasdfas")
    }
}
