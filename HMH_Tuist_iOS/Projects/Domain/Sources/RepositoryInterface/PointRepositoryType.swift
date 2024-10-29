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
    func patchPointUse() -> AnyPublisher<UserPointInfo, Error>
    func getEarnPoint() -> AnyPublisher<Int, Error>
    func getUsagePoint() -> AnyPublisher<Int, Error>
    func getPointList() -> AnyPublisher<PointDetail, Error>
    func patchEarnPoint(date: String) -> AnyPublisher<Int, Error>
}
