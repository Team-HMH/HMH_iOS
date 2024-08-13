//
//  UserService.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import Combine
import Domain
import Networks

typealias DefaultUserService = BaseService<UserAPI>

import Foundation

public struct BaseResponse<T: Decodable>: Decodable {
    public var status: Int
    public var message: String?
    public var data: T?
}

protocol UserServiceType {
    func getUserData() -> AnyPublisher<BaseResponse<GetUserDataResponseDTO>, Error>
}

extension DefaultUserService: UserServiceType {
    func getUserData() -> AnyPublisher<BaseResponse<GetUserDataResponseDTO>, Error> {
        return requestObjectWithNetworkErrorInCombine(.getUserData)
    }
}

class StubUserService: UserServiceType {
    func getUserData() -> AnyPublisher<BaseResponse<GetUserDataResponseDTO>, Error> {
        Empty().eraseToAnyPublisher()
    }
}
