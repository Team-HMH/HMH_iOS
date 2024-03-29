//
//  NextButtonView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

struct NextButtonView: View {
    
    @EnvironmentObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Button {
                viewModel.addOnboardingState()
                viewModel.offIsCompleted()
            } label: {
                Text(viewModel.getNextButton())
                    .font(.text4_semibold_16)
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

//#Preview {
//    NextButtonView()
//}
