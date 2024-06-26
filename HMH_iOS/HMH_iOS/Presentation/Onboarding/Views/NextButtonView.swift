//
//  NextButtonView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

struct NextButtonView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Button {
                viewModel.saveOnboardingData()
            } label: {
                Text(viewModel.getNextButton())
                    .font(.text4_semibold_16)
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .foregroundColor(viewModel.isCompleted ? .whiteBtn : .gray2)
            .background(viewModel.isCompleted ? .bluePurpleButton : .gray5)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .disabled(!viewModel.isCompleted)
        }
    }
}


