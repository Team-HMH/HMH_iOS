//
//  LoginView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/2/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        ZStack {
            Color(.blackground)
                .ignoresSafeArea()
            VStack(spacing: 10) {
                SwipeView(imageNames: [.onboardingFirst, .onboardingSecond, .onboardingThird])
                    .padding(.bottom, 75)
                LoginButton(loginProvider: .kakao, viewModel: viewModel)
                LoginButton(loginProvider: .apple, viewModel: viewModel)
            }
        }
        .frame(maxHeight: .infinity)
        .padding(.vertical, 22)
    }
}


