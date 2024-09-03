//
//  MyPageUseCase.swift
//  MyPageFeature
//
//  Created by 류희재 on 9/3/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine
import Core
import Domain

protocol MyPageUseCaseType {
    func getUserDate() -> AnyPublisher<GetUserDataResponseDTO, Error>
    func logout()
    func revokeUser()
}

final class MyPageUseCase: MyPageUseCaseType {
    private var container: DIContainer
    private var cancelBag = CancelBag()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func getUserDate() -> AnyPublisher<GetUserDataResponseDTO, Error> {
        container.services.userService.getUserData()
            .map { $0.data! }
            .eraseToAnyPublisher()
    }
    
    func logout() {
        container.services.authService.logoutUser()
            .sink { _ in
            } receiveValue: {  _ in
                UserManager.shared.clearLogout()
            }.store(in: cancelBag)
    }
    
    func revokeUser() {
        container.services.authService.revokeUser()
            .sink { _ in
            } receiveValue: {  _ in
                UserManager.shared.revokeData()
            }.store(in: cancelBag)
    }
}
