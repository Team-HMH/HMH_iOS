//
//  LogoutAlertView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/14/24.
//

import SwiftUI


struct LogoutAlertView: View {
    let confirmBtn: CustomAlertButtonView
    let cancelBtn: CustomAlertButtonView
    
    var body: some View {
        VStack(spacing: .zero) {
            Spacer()
                .frame(height: 55)
            Text(StringLiteral.AlertTitle.logout)
                .foregroundColor(.whiteText)
                .font(.text3_semibold_18)
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 34)
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
