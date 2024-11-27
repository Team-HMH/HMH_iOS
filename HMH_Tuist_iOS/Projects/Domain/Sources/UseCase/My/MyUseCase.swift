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
    var logoutFailed: PassthroughSubject<String, Never> { get }
    var revokeUserFailed: PassthroughSubject<String, Never> { get }
    
    func getUserData() -> AnyPublisher<User, UserError>
    func logout() -> AnyPublisher<Void, Never>
    func revokeUser() -> AnyPublisher<Void, Never>
}

final class MyPageUseCase: MyPageUseCaseType {
    
    private let userRepository: UserRepositoryType
    private var cancelBag = CancelBag()
    
    init(userRepository: UserRepositoryType) {
        self.userRepository = userRepository
    }
    
    var logoutFailed = PassthroughSubject<String, Never>()
    var revokeUserFailed = PassthroughSubject<String, Never>()
    
    func getUserData() -> AnyPublisher<User, UserError> {
        userRepository.getUserData()
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    func logout() -> AnyPublisher<Void, Never> {
        userRepository.logout()
            .catch { [weak self] error in
                self?.logoutFailed.send("로그아웃에 실패했습니다.")
                return Just(())
            }
            .eraseToAnyPublisher()
    }
    
    func revokeUser() -> AnyPublisher<Void, Never> {
        userRepository.deleteAccount()
            .catch { [weak self] error in
                self?.revokeUserFailed.send("회원탈퇴에 실패했습니다.")
                return Just(())
            }
            .eraseToAnyPublisher()
    }
}
