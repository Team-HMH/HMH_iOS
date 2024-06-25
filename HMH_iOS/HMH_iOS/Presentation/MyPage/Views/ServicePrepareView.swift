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
                Text(StringLiteral.MyPageButton.market)
                    .font(.text3_semibold_18)
                    .foregroundColor(.whiteText)
                Spacer()
            }
            .frame(height: 60)
            Spacer()
                .frame(height: 213)
            Text(StringLiteral.Prepare.title)
                .font(.text3_semibold_18)
                .foregroundColor(.whiteText)
                .padding()
            Text(StringLiteral.Prepare.subtitle)
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
                Text(StringLiteral.Prepare.button)
                    .foregroundColor(.whiteBtn)
                    .font(.text5_medium_16)
                    .frame(width: 225, height: 52)
            }
            .background(.bluePurpleButton)
            .cornerRadius(8)
            Spacer()
        }
        .navigationBarHidden(true)
    }
}


