//
//  UsePointsAlertView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/14/24.
//


import SwiftUI


struct UsePointsAlertView: View {
    let confirmBtn: CustomAlertButtonView
    let cancelBtn: CustomAlertButtonView
    let currentPoint: Int
    let usagePoint: Int
    
    var body: some View {
        VStack(spacing: 22) {
            Text("\(usagePoint)" + StringLiteral.AlertTitle.usePoints)
                .foregroundColor(DSKitAsset.whiteText.swiftUIColor)
                .font(.text3_semibold_18)
                .multilineTextAlignment(.center)
            Image(uiImage: DSKitAsset.lock.image)
                .resizable()
                .frame(width: 90, height: 90)
            HStack(spacing: 26) {
                Text("보유 포인트")
                    .font(.text5_medium_16)
                    .foregroundColor(DSKitAsset.gray1.swiftUIColor)
                Text("\(currentPoint)P")
                    .font(.text5_medium_16)
                    .foregroundColor(DSKitAsset.whiteText.swiftUIColor)
            }
            HStack(spacing: 8) {
                cancelBtn
                    .frame(width: 236)
            }
            .frame(width: 266, height: 52)
        }
    }
}



