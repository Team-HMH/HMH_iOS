//
//  ServicePrepareView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 6/9/24.
//

import SwiftUI

import Core
import DSKit

public struct ServicePrepareView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    public init() {} 
    
    public var body: some View {
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
                    Image(uiImage: DSKitAsset.chevronLeft.image)
                }
                Spacer()
                    .frame(width: 12)
                Text(StringLiteral.MyPageButton.market)
                    .font(.text3_semibold_18)
                    .foregroundColor(DSKitAsset.whiteText.swiftUIColor)
                Spacer()
            }
            .frame(height: 60)
            Spacer()
                .frame(height: 213)
            Text(StringLiteral.Prepare.title)
                .font(.text3_semibold_18)
                .foregroundColor(DSKitAsset.whiteText.swiftUIColor)
                .padding()
            Text(StringLiteral.Prepare.subtitle)
                .font(.text6_medium_14)
                .foregroundColor(DSKitAsset.gray2.swiftUIColor)
                .padding(EdgeInsets(top: 12, leading: 0, bottom: 35, trailing: 0))
            Button {
                if presentationMode.wrappedValue.isPresented {
                    dismiss()
                } else {
                    UserManager.shared.appStateString = "home"
                }
            } label: {
                Text(StringLiteral.Prepare.button)
                    .foregroundColor(DSKitAsset.whiteBtn.swiftUIColor)
                    .font(.text5_medium_16)
                    .frame(width: 225, height: 52)
            }
            .background(DSKitAsset.bluePurpleButton.swiftUIColor)
            .cornerRadius(8)
            Spacer()
        }
        .navigationBarHidden(true)
    }
}


