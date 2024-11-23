//
//  PoinstServiceTestView.swift
//  NetworksDemo
//
//  Created by 류희재 on 11/21/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI
import Networks
import Core

//디버그(Debug) 모드와 릴리즈(Release) 모드에서 Xcode의 프리뷰(Preview) 활성화 여부 다름 So QA를 다시 debug로 변경

struct NetworkTestHomeView: View {
    @EnvironmentObject var container: DIContainer
    
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
                
                Text("테스트하고자하는 Service를 클릭해주세요!")
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
                        imageResource: .auth,
                        title: "Auth") {
                            container.navigationRouter.push(to: .auth)
                        }
                    
                    Spacer()
                        .frame(width: 25)
                    
                    ServiceButton(
                        imageResource: .challenge,
                        title: "Challenge") {
                            container.navigationRouter.push(to: .challenge)
                        }
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 25)
                
                HStack {
                    
                    Spacer()
                    
                    ServiceButton(
                        imageResource: .point,
                        title: "Point") {
                            container.navigationRouter.push(to: .point)
                        }
                    
                    Spacer()
                        .frame(width: 25)
                    
                    ServiceButton(
                        imageResource: .user,
                        title: "User") {
                            container.navigationRouter.push(to: .user)
                        }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.horizontal, 30)
            .background(Color(asset: NetworksDemoAsset.blackground))
        }
        }
        
}

fileprivate struct ServiceButton : View {
    
    let imageResource: ImageResource
    let title: String
    let action: () -> Void
    
    fileprivate var body: some View {
        Button {
            action()
        } label: {
            
            VStack {
                Image(imageResource)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                Text(title)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(.top, 7)
                
            }
            .frame(width: 145, height: 145)
            .background(.clear)
            .multilineTextAlignment(.center)
            .shadow(radius: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.white), lineWidth: 1)
            )
            
        }
    }
}

#Preview {
    return NetworkTestHomeView()
        .environmentObject(DIContainer.default)
}

