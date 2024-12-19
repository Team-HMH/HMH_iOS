//
//  OnboardingCoordinator.swift
//  Coordinator
//
//  Created by 이지희 on 11/15/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI

import OnboardingFeature

final class OnboardingCoordinator: ObservableObject, CoordinatorType {
    var parentCoordinator: (any CoordinatorType)?
    
    var navigationPath: NavigationPath
    
    init(
        parentCoordinator: (any CoordinatorType)? = nil,
        navigationPath: NavigationPath
    ) {
        self.parentCoordinator = parentCoordinator
        self.navigationPath = navigationPath
    }
    
    func start() -> AnyView {
        return AnyView(OnboardingContentView())
    }
}
