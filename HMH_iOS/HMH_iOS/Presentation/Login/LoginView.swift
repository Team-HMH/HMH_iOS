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
        VStack(spacing: 10) {
            SwipeView(imageNames: [.onboardingFirst, .onboardingSecond, .onboardingThird])
            Spacer()
                .frame(height: 75)
            LoginButton(loginProvider: .kakao, viewModel: viewModel)
            LoginButton(loginProvider: .apple, viewModel: viewModel)
            Spacer()
                .frame(height: 22)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blackground, ignoresSafeAreaEdges: .all)
    }
}


