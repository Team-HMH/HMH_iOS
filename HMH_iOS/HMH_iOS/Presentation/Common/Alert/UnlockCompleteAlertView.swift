//
//  UnlockCompleteAlertView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/14/24.
//

import SwiftUI


struct UnlockCompleteAlertView: View {
    let confirmBtn: CustomAlertButtonView
    let currentPoint: Int
    let usagePoint: Int
    
    var body: some View {
        VStack(spacing: 14) {
            Text("\(usagePoint)" + StringLiteral.AlertTitle.unlockComplete)
                .foregroundColor(.whiteText)
                .font(.text3_semibold_18)
                .multilineTextAlignment(.center)
            Text(StringLiteral.AlertDescription.unlockComplete)
                .foregroundColor(.gray1)
                .font(.text6_medium_14)
                .multilineTextAlignment(.center)
            Image(uiImage: .challengeFail)
                .resizable()
                .frame(width: 120, height: 120)
            HStack(spacing: 26) {
                Text("보유 포인트")
                    .font(.text5_medium_16)
                    .foregroundColor(.gray1)
                Text("\(currentPoint)P")
                    .font(.text5_medium_16)
                    .foregroundColor(.whiteText)
            }
            HStack(spacing: 8) {
                confirmBtn
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 266, height: 52)
            .padding(EdgeInsets(top: 22, leading: 0, bottom: 0, trailing: 0))
        }
    }
}
