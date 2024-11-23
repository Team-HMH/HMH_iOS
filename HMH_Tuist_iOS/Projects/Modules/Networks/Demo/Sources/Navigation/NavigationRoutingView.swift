////
////  NavigationRoutingView.swift
////  NetworksDemo
////
////  Created by 류희재 on 11/23/24.
////  Copyright © 2024 HMH-iOS. All rights reserved.
////
//
import Foundation
import SwiftUI
import Networks

struct NavigationRoutingView: View {
    
    @State var destination: NavigationDestination
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        switch destination {
        case .home:
            NetworkTestHomeView()
        case .auth:
            AuthServiceView(
                viewModel: AuthServiceViewModel(
                    service: container.service.authService,
                    navigationRouter: container.navigationRouter
                )
            )
        case .challenge:
            ChallengeServiceView(
                viewModel: ChallengeServiceViewModel(
                    service: container.service.challengeService,
                    navigationRouter: container.navigationRouter
                )
            )
            .environmentObject(DIContainer.default)
        case .point:
            PointServiceView(
                viewModel: PointServiceViewModel(
                    service: container.service.pointService,
                    navigationRouter: container.navigationRouter
                )
            )
        case .user:
            UserServiceView(
                viewModel: UserServiceViewModel(
                    service: container.service.userService,
                    navigationRouter: container.navigationRouter
                )
            )
        }
    
    }
}


extension View {
    func setHMHNavigation() -> some View {
        self.navigationDestination(for: NavigationDestination.self) { destination in
            return NavigationRoutingView(destination: destination)
        }
    }
}

