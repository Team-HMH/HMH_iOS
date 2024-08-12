//
//  UnlockAlertVIew.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/14/24.
//

import SwiftUI


struct UnlockAlertView: View {
    let confirmBtn: CustomAlertButtonView
    let cancelBtn: CustomAlertButtonView
    
    var body: some View {
        VStack(spacing: 14) {
            Text(StringLiteral.AlertTitle.unlock)
                .foregroundColor(DSKitAsset.whiteText.swiftUIColor)
                .font(.text3_semibold_18)
                .multilineTextAlignment(.center)
            Text(StringLiteral.AlertDescription.unlock)
                .foregroundColor(DSKitAsset.gray1.swiftUIColor)
                .font(.text6_medium_14)
                .multilineTextAlignment(.center)
            Image(uiImage: DSKitAsset.challengeWarn.image)
                .resizable()
                .frame(width: 120, height: 120)
            HStack(spacing: 8) {
                confirmBtn
                cancelBtn
                    .frame(width: 160)
            }
            .frame(width: 266, height: 52)
        }
    }
}
