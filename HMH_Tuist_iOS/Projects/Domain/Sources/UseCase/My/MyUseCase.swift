//
//  MyUseCase.swift
//  Domain
//
//  Created by 류희재 on 11/26/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine
import Core

public protocol MyPageUseCaseType {
    func getUserDate() -> AnyPublisher<User, UserError>
    func logout()
    func revokeUser()
}

final class MyPageUseCase: MyPageUseCaseType {
    private let userRepository: UserRepositoryType
    private var cancelBag = CancelBag()
    
    init(userRepository: UserRepositoryType) {
        self.userRepository = userRepository
    }
    
    func getUserDate() -> AnyPublisher<User, UserError> {
        userRepository.getUserData()
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    func logout() {
        userRepository.logout()
            .sink { _ in
            } receiveValue: {  _ in
                UserManager.shared.clearLogout()
            }.store(in: cancelBag)
    }
    
    func revokeUser() {
        userRepository.deleteAccount()
            .sink { _ in
            } receiveValue: {  _ in
                UserManager.shared.revokeData()
            }.store(in: cancelBag)
    }
}
