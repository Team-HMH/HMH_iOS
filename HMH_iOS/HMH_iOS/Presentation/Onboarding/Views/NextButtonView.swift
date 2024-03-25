//
//  NextButtonView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

struct NextButtonView: View {
    
    @State
    private var isActive = true
    
    @Binding
    var onboardingState: Int
    
    var body: some View {
        VStack {
            Button {
                onboardingState += 1
            } label: {
                Text("권한 설정하러 가기")
                    .font(.text4_semibold_16)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .foregroundColor(isActive ? .whiteBtn : .gray2)
            .background(isActive ? .bluePurpleButton : .gray5)
            .clipShape(RoundedRectangle(cornerRadius: 4))
        }
    }
}

//#Preview {
//    NextButtonView()
//}
