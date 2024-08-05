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
                .foregroundColor(.bluePurpleButton)
            
            configuration.label
                .font(.text4_semibold_16)
                .foregroundColor(.whiteBtn)
        }
    }
}

struct CustomButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 52)
            .frame(maxWidth: .infinity)
            .background(.bluePurpleButton)
            .foregroundColor(.whiteBtn)
            .cornerRadius(4)
            .padding(.horizontal, 21)
    }
}
