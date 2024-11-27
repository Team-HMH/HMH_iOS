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
    var navigationPath: NavigationPath
    private let diContainer: AuthDIContainer

    init(
        navigationPath: NavigationPath,
        diContainer: AuthDIContainer
    ) {
        self.navigationPath = navigationPath
        self.diContainer = diContainer
    }

    func start() -> AnyView {
        let viewModel = diContainer.injectLoginViewModel()
        let view = LoginView(viewModel: viewModel)
        return AnyView(view)
    }
}
