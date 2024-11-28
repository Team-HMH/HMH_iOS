//
//  MyPageDemoApp.swift
//  MyPageFeature
//
//  Created by 류희재 on 11/28/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI

import Domain
import Data
import Networks
import MyPageFeature

@main
struct MyPageDemoApp: App {
    var body: some Scene {
        WindowGroup {
            MyPageView(
                viewModel: MyPageViewModel(
                    useCase: MyPageUseCase(
                        userRepository: UserRepository(
                            service: UserService()
                        )
                    )
                )
            )
        }
    }
}
