//
//  ServicePrepareView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 6/9/24.
//

import SwiftUI

struct ServicePrepareView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 14)
                Button {
                    if presentationMode.wrappedValue.isPresented {
                        dismiss()
                    } else {
                        UserManager.shared.appStateString = "home"
                    }
                } label: {
                    Image(.chevronLeft)
                }
                Spacer()
                    .frame(width: 12)
                Text("우주 상점")
                    .font(.text3_semibold_18)
                    .foregroundColor(.whiteText)
                Spacer()
            }
            .frame(height: 60)
            Spacer()
                .frame(height: 213)
            Text("서비스 준비 중이에요")
                .font(.text3_semibold_18)
                .foregroundColor(.whiteText)
                .padding()
            Text("더 나은 서비스가 될테니\n조금만 기다려 주세요 :)")
                .font(.text6_medium_14)
                .foregroundColor(.gray2)
                .padding(EdgeInsets(top: 12, leading: 0, bottom: 35, trailing: 0))
            Button {
                if presentationMode.wrappedValue.isPresented {
                    dismiss()
                } else {
                    UserManager.shared.appStateString = "home"
                }
            } label: {
                Text("서비스 센터에 연락해 해제")
                    .foregroundColor(.whiteBtn)
                    .font(.text5_medium_16)
                    .frame(width: 225, height: 52)
            }
            .background(.bluePurpleButton)
            .cornerRadius(8)
            Spacer()
        }
    }
}


