//
//  TokenTestView.swift
//  NetworksDemo
//
//  Created by 류희재 on 11/24/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI
import Networks
import Core

//디버그(Debug) 모드와 릴리즈(Release) 모드에서 Xcode의 프리뷰(Preview) 활성화 여부 다름 So QA를 다시 debug로 변경

struct TokenTestHomeView: View {
    @EnvironmentObject var container: DIContainer
    private let cancelBag = CancelBag()
    
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destinations) {
            VStack(alignment: .center) {
                Spacer()
                    .frame(height: 25)
                
                Image(.main)
                    .resizable()
                    .frame(width: 86, height: 86)
                
                Spacer()
                    .frame(height: 20)
                
                Text("HMH-iOS\nNetwork Demo App")
                    .foregroundStyle(.white)
                    .frame(alignment: .center)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Spacer()
                    .frame(height: 20)
                
                Text("테스트를 하기 전, idToken부터 받으세요!")
                    .foregroundStyle(.gray)
                    .frame(alignment: .center)
                    .font(.body)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Spacer()
                    .frame(height: 60)
                
                HStack {
                    Spacer()
                    ServiceButton(
                        imageResource: .kakaoLogo,
                        backgroundColor: .yellow,
                        title: "KAKAO") {
                            let oauthKakaoService = OAuthKakaoService()
                            oauthKakaoService.authorize()
                                .sink(receiveCompletion: { _ in
                                    
                                }, receiveValue: { token in
                                    UserManager.shared.accessToken = token
                                    container.navigationRouter.push(to: .home)
                                })
                                .store(in: cancelBag)

                        }
                    
                    Spacer()
                        .frame(width: 25)
                    
                    ServiceButton(
                        imageResource: .appleLogo,
                        backgroundColor: .white,
                        title: "APPLE") {
                            container.navigationRouter.push(to: .home)
                        }
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            .setHMHNavigation()
            .background(Color(asset: NetworksDemoAsset.blackground))
        }
    }
}

#Preview {
    return TokenTestHomeView()
        .environmentObject(DIContainer.stub)
}
