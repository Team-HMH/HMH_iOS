//
//  GetPointListUsecase.swift
//  Domain
//
//  Created by 이지희 on 11/4/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol FetchPointListUseCaseType {
    func execute() -> AnyPublisher<[PointStatuse], Error>
}

/// 유저 포인트
public final class FetchPointInfoUseCase: FetchPointListUseCaseType {
    private let repository: PointRepositoryType
    
    public init(repository: PointRepositoryType) {
        self.repository = repository
    }
    
    public func execute() -> AnyPublisher<[PointStatuse], Error> {
        return repository.getPointList()
            .map { $0.pointStatuses }
            .eraseToAnyPublisher()
    }
}
