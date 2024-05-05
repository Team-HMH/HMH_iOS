//
//  NavigationView.swift
//  HMH_iOS
//
//  Created by 이지희 on 3/31/24.
//

import SwiftUI

struct NavigationBarView: View {
    @Environment(\.dismiss) var dismiss
    
    let showBackButton: Bool
    let showPointButton: Bool
    let title: String
    
    var body: some View {
        ZStack {
            Color.blackground
                .ignoresSafeArea()
            OnboardingTitleView()
        }
        .frame(height: 60)
    }
}

extension NavigationBarView {
    private func OnboardingTitleView() -> some View {
        var titleView: some View {
            HStack{
                if showBackButton {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(.chevronLeft)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 20)
                    }
                    .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 8))
                } else {
                    Image(.chevronLeft).hidden()
                        .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 0))
                }
                Text(title).foregroundStyle(Color.gray1)
                    .font(.text3_semibold_18)
                    .frame(maxWidth: .infinity,
                           alignment: .center)
                if showPointButton {
                    Button(action: {
                        print("포인트 버튼")
                    }) {
                        Image(.navigationPoint)
                        
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                } else {
                    Image(.navigationPoint).hidden()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                }
            }
        }
        return titleView
    }
}

#Preview {
    NavigationBarView(showBackButton: false, showPointButton: false, title: "마이페이지")
}
