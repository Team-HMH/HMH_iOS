//
//  LoginButton.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/6/24.
//

import SwiftUI

import DSKit
import Domain

struct LoginButton: View {
    var loginProvider: OAuthProviderType = .apple
    @ObservedObject var viewModel: LoginViewModel
    var signInLogoImage = DSKitAsset.appleLogo.swiftUIImage
    
    var body: some View {
        Button(action: {
            viewModel.send(action: .loginButtonDidTap(provider: loginProvider))
        }) {
            RoundedRectangle(cornerRadius: 6.3)
                .frame(width:336, height: 51)
                .foregroundColor(loginProvider == .apple ? DSKitAsset.whiteBtn.swiftUIColor : DSKitAsset.yelloBtn.swiftUIColor)
                .overlay(
                    HStack {
                        Image(uiImage: loginProvider == .apple ? DSKitAsset.appleLogo.image : DSKitAsset.kakaoLogo.image)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.leading, 14)
                            .padding(.trailing, loginProvider == .apple ? 63 : 75)
                        Text(loginProvider == .apple ? StringLiteral.LoginButton.apple : StringLiteral.LoginButton.kakao)
                            .foregroundColor(DSKitAsset.gray8.swiftUIColor)
                            .font(.text4_semibold_16)
                        Spacer()
                    }
                )
        }
    }
}
