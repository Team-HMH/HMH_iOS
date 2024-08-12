//
//  CustomButtonModifier.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/26/24.
//


import SwiftUI

struct HMHButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Rectangle()
                .frame(height: 52)
                .cornerRadius(4)
                .foregroundColor(DSKitAsset.bluePurpleButton.swiftUIColor)
            
            configuration.label
                .font(.text4_semibold_16)
                .foregroundColor(DSKitAsset.whiteBtn.swiftUIColor)
        }
    }
}

public struct CustomButtonStyle: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View {
        content
            .frame(height: 52)
            .frame(maxWidth: .infinity)
            .background(DSKitAsset.bluePurpleButton.swiftUIColor)
            .foregroundColor(DSKitAsset.whiteBtn.swiftUIColor)
            .cornerRadius(4)
            .padding(.horizontal, 21)
    }
}
