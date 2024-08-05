//
//  WithdrawAlertView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/14/24.
//

import SwiftUI


struct WithdrawAlertView: View {
    let confirmBtn: CustomAlertButtonView
    let cancelBtn: CustomAlertButtonView
    
    var body: some View {
        VStack(spacing: .zero) {
            Spacer()
                .frame(height: 36)
            Text(StringLiteral.AlertTitle.withdraw)
                .foregroundColor(DSKitAsset.whiteText.swiftUIColor)
                .font(.text3_semibold_18)
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 14)
            Text(StringLiteral.AlertDescription.withdraw)
                .foregroundColor(DSKitAsset.gray1.swiftUIColor)
                .font(.text6_medium_14)
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 29)
            HStack(spacing: 8) {
                confirmBtn
                cancelBtn
                    .frame(width: 129)
            }
            .frame(width: 266, height: 52)
            Spacer()
                .frame(height: 22)
        }
    }
}
