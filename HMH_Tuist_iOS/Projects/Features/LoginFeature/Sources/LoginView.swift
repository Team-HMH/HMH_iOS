//
//  LoginView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/2/24.
//

import SwiftUI

import DSKit
import Domain

public struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack {
            Color(DSKitAsset.blackground.swiftUIColor)
                .ignoresSafeArea()
            VStack(spacing: 10) {
                //TODO: 이미지 타입 문제거 같은데 지금 해결하기엔 싱싱미역
                SwipeView(swipeImages: [DSKitAsset.onboardingFirst.swiftUIImage, DSKitAsset.onboardingSecond.swiftUIImage, DSKitAsset.onboardingThird.swiftUIImage])
                    .padding(.bottom, 75)
                LoginButton(loginProvider: OAuthProviderType.kakao, viewModel: viewModel)
                LoginButton(loginProvider: OAuthProviderType.apple, viewModel: viewModel)
            }
        }
        .frame(maxHeight: .infinity)
        .padding(.vertical, 22)
    }
}
