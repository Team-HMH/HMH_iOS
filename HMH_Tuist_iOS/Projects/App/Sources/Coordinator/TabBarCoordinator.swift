//
//  TabBarCoordinator.swift
//  Coordinator
//
//  Created by 이지희 on 11/15/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI

class TabBarCoordinator: ObservableObject, CoordinatorType {
    var navigationPath: NavigationPath
    
    var parentCoordinator: (any CoordinatorType)?
    
    @Published var selectedTab: Tab = .home
    
    init(
        parentCoordinator: CoordinatorType,
        navigationPath: NavigationPath
    ) {
        self.parentCoordinator = parentCoordinator
        self.navigationPath = navigationPath
    }
    
    func start() -> AnyView {
        AnyView(TabBarView())
    }
    
    enum Tab {
        case home
        case challenge
        case myPage
    }
}
