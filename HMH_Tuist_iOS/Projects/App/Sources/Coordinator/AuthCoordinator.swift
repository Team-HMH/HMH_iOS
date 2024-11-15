//
//  LoginCoordinator.swift
//  Coordinator
//
//  Created by 이지희 on 11/15/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI

import LoginFeature

final class AuthCoordinator: ObservableObject, CoordinatorType {
    var parentCoordinator: (any CoordinatorType)?
    
    var navigationPath: NavigationPath
    
    init(
        parentCoordinator: any CoordinatorType,
        navigationPath: NavigationPath
    ) {
        self.parentCoordinator = parentCoordinator
        self.navigationPath = navigationPath
    }
    
    func start() -> AnyView {
        return AnyView(LoginView(viewModel: LoginViewModel()))
    }
}
