//
//  PointRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol PointRepositoryType {
    func patchPointUse() -> AnyPublisher<UserPointInfo, PointError>
    func getEarnPoint() -> AnyPublisher<Int, PointError>
    func getUsagePoint() -> AnyPublisher<Int, PointError>
    func getPointList() -> AnyPublisher<PointDetail, PointError>
    func patchEarnPoint(date: String) -> AnyPublisher<Int, PointError>
}
