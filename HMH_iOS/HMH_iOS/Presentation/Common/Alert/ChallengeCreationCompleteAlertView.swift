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
            Image(uiImage: .challengeCreate)
                .resizable()
                .frame(width: 120, height: 120)
            Text(StringLiteral.AlertTitle.challengeCreationComplete)
                .foregroundColor(.whiteText)
                .font(.text3_semibold_18)
                .multilineTextAlignment(.center)
            Text(StringLiteral.AlertDescription.challengeCreationComplete)
                .foregroundColor(.gray1)
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
