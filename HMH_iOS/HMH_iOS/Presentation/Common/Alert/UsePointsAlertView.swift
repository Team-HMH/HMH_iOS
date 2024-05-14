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
    
    var body: some View {
        VStack(spacing: 22) {
            Text(StringLiteral.AlertTitle.usePoints)
                .foregroundColor(.whiteText)
                .font(.text3_semibold_18)
                .multilineTextAlignment(.center)
            Image(uiImage: .lock)
                .resizable()
                .frame(width: 90, height: 90)
            HStack(spacing: 26) {
                Text("보유 포인트")
                    .font(.text5_medium_16)
                    .foregroundColor(.gray1)
                Text("00P")
                    .font(.text5_medium_16)
                    .foregroundColor(.whiteText)
            }
            HStack(spacing: 8) {
                cancelBtn
                    .frame(width: 236)
            }
            .frame(width: 266, height: 52)
        }
    }
}



