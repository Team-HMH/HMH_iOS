//
//  LoginView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/2/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        VStack(spacing: 10) {
            SwipeView(imageNames: [.onboardingFirst, .onboardingFirst, .onboardingThird])
            Spacer()
            LoginButton(loginProvider: .kakao, viewModel: viewModel)
            LoginButton(loginProvider: .apple, viewModel: viewModel)
            Spacer()
                .frame(height: 22)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blackground, ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    LoginView()
}

