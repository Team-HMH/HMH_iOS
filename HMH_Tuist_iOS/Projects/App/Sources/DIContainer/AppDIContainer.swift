//
//  AppDIConatiner.swift
//  HMH-iOS
//
//  Created by 이지희 on 11/27/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI

import Networks
import Data
import Domain

final class AppDIContainer: ObservableObject {
    
    // Auth DI
    func injectAuthDIContainer() -> AuthDIContainer {
        let service = injectAuthService()
        let serviceFactory = injectOAuthFactory()
        return AuthDIContainer(services: service, oAuthServiceFactory: serviceFactory)
    }
    
    private func injectAuthService() -> AuthService {
        return AuthService()
    }
    
    private func injectOAuthFactory() -> OAuthServiceFactory {
        return OAuthServiceFactory()
    }
}
