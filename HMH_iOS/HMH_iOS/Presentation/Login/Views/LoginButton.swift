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
    
    var logoImage: String {
        switch self {
        case .apple:
            return "appleLogo"
        case .kakao:
            return "kakaoLogo"
        }
    }
}

struct LoginButton: View {
    let provider: SignInProvider
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        Button(action: {
            if provider == .apple {
                viewModel.handleAppleLogin()
            } else if provider == .kakao {
                viewModel.handleKakaoLogin()
            }
        }) {
            RoundedRectangle(cornerRadius: 6.3)
                .frame(width:336, height: 51)
                .foregroundColor(provider == .apple ? .whiteBtn : .yelloBtn)
                .overlay(
                    HStack {
                        Image(provider.logoImage)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.leading, 14)
                            .padding(.trailing, provider == .apple ? 63 : 75)
                        Text(provider == .apple ? StringLiteral.LoginButton.apple : StringLiteral.LoginButton.kakao)
                            .foregroundColor(.gray8)
                            .font(.text4_semibold_16)
                        Spacer()
                    }
                )
        }
    }
}
