//
//  NextButtonView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

import DSKit

struct NextButtonView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Button {
                viewModel.send(action: .nextButtonTap)
            } label: {
                Text(viewModel.state.onboardingState.nextButtonTitle)
                    .font(.text4_semibold_16)
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .foregroundColor(
                viewModel.state.isNextAvailable ? DSKitAsset.whiteBtn.swiftUIColor : DSKitAsset.gray2.swiftUIColor)
            .background(viewModel.state.isNextAvailable ? DSKitAsset.bluePurpleButton.swiftUIColor : DSKitAsset.gray5.swiftUIColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .disabled(!viewModel.state.isNextAvailable)
        }
    }
}


