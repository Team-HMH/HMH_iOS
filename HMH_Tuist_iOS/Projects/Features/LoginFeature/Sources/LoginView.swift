//
//  LoginView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/2/24.
//

import SwiftUI
import AuthenticationServices

import DSKit

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        ZStack {
            Color(DSKitAsset.blackground.swiftUIColor)
                .ignoresSafeArea()
            VStack(spacing: 10) {
                //TODO: 이미지 타입 문제거 같은데 지금 해결하기엔 싱싱미역
//                SwipeView(imageNames: [.onboardingFirst, .onboardingSecond, .onboardingThird])
//                    .padding(.bottom, 75)
                LoginButton(loginProvider: .kakao, viewModel: viewModel)
                LoginButton(loginProvider: .apple, viewModel: viewModel)
            }
        }
        .frame(maxHeight: .infinity)
        .padding(.vertical, 22)
    }
}


