//
//  ChallengeCreationCompleteAlertView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/14/24.
//

import SwiftUI


struct ChallengeCreationCompleteAlertView: View {
    let cancelBtn: CustomAlertButtonView
    
    var body: some View {
        VStack(spacing: 10) {
            Image(uiImage: DSKitAsset.challengeCreate.image)
                .resizable()
                .frame(width: 120, height: 120)
            Text(StringLiteral.AlertTitle.challengeCreationComplete)
                .foregroundColor(DSKitAsset.whiteText.swiftUIColor)
                .font(.text3_semibold_18)
                .multilineTextAlignment(.center)
            Text(StringLiteral.AlertDescription.challengeCreationComplete)
                .foregroundColor(DSKitAsset.gray1.swiftUIColor)
                .font(.text6_medium_14)
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 19)
            HStack(spacing: 8) {
                cancelBtn
                    .frame(width: 238)
            }
            .frame(width: 266, height: 52)
        }
    }
}
