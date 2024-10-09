//
//  LoginUseCase.swift
//  LoginFeatureInterface
//
//  Created by Seonwoo Kim on 10/9/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine
import Core
import Domain

public enum LoginResponseType {
    case loginSuccess
    case loginFailure
    case noUserInfo
}

protocol LoginUseCaseType {
    func requestLogin(platform: String, socialToken: String) -> AnyPublisher<SocialLogineResponseDTO, Error>
    var loginResponse: CurrentValueSubject<LoginResponseType, Error> { get set }
}

final class LoginUseCase: LoginUseCaseType {
    
    public var loginResponse = CurrentValueSubject<LoginResponseType, Error>(.loginFailure)
    
    
    private var container: DIContainer
    private var cancelBag = CancelBag()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func requestLogin(platform: String, socialToken: String) -> AnyPublisher<Domain.SocialLogineResponseDTO, any Error>  {
        return container.services.userService.signIn(platform: platform)
            .handleEvents(receiveOutput: { response in
                UserManager.shared.socialToken = socialToken
                UserManager.shared.accessToken = response.data
                UserManager.shared.refreshToken = response.data
            })
            .map { response in
                handleLoginResponse(statusCode: response.statusCode)
            }
            .eraseToAnyPublisher()
    }
    
    private func handleLoginResponse(statusCode: Int) -> LoginResponseType {
        switch statusCode {
        case 200..<300:
            self.loginResponse.send(.loginSuccess)
            return .loginSuccess
        case 403:
            self.loginResponse.send(.noUserInfo)
            return .noUserInfo
        default:
            self.loginResponse.send(.loginFailure)
            return .loginFailure
        }
    }
}

