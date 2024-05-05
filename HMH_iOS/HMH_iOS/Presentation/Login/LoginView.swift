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
        VStack {
            SwipeView(imageNames: [.onboardingFirst, .onboardingFirst, .onboardingThird])
            AppleSigninButton(viewModel: viewModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blackground, ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    LoginView()
}

struct AppleSigninButton: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        SignInWithAppleButton { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case .success(let authResults):
                switch authResults.credential {
                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                    viewModel.handleAppleIDCredential(appleIDCredential)
                default:
                    break
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 50)
        .cornerRadius(5)
    }
}
