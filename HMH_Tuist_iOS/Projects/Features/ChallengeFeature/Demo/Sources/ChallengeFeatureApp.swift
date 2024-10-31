//
//  ChallengeFeatureApp.swift
//  ChallengeFeatureInterface
//
//  Created by 이지희 on 11/1/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI

import ChallengeFeature

@main
struct ChallengeFeatureApp: App {
    init() { }

    var body: some Scene {
        WindowGroup {
          ChallengeView(viewModel: .init())
        }
    }
}
