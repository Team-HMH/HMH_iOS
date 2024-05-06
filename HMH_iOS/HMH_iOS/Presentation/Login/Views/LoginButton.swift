//
//  LoginButton.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/6/24.
//

import SwiftUI
import AuthenticationServices

enum SignInProvider {
    case apple
    case kakao
    
    var signInLogoImage: String {
        switch self {
        case .apple:
            return "appleLogo"
        case .kakao:
            return "kakaoLogo"
        }
    }
}

struct LoginButton: View {
    let loginProvider: SignInProvider
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        Button(action: {
            if loginProvider == .apple {
                viewModel.handleAppleLogin()
            } else if loginProvider == .kakao {
                viewModel.handleKakaoLogin()
            }
        }) {
            RoundedRectangle(cornerRadius: 6.3)
                .frame(width:336, height: 51)
                .foregroundColor(loginProvider == .apple ? .whiteBtn : .yelloBtn)
                .overlay(
                    HStack {
                        Image(loginProvider.signInLogoImage)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.leading, 14)
                            .padding(.trailing, loginProvider == .apple ? 63 : 75)
                        Text(loginProvider == .apple ? StringLiteral.LoginButton.apple : StringLiteral.LoginButton.kakao)
                            .foregroundColor(.gray8)
                            .font(.text4_semibold_16)
                        Spacer()
                    }
                )
        }
    }
}
