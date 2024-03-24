//
//  OnboardingContentView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

struct OnboardingContentView: View {
    
    @StateObject
    private var viewModel = OnboardingViewModel()
    
    @State
    private var OnboardingState = 3
    
    var body: some View {
        VStack {
            OnboardingProgressView(onboardingState: $OnboardingState)
            //            SurveyContainerView()
            //            NextButtonView()
        }
        .background(.blackground, ignoresSafeAreaEdges: .all)
    }
}

extension OnboardingContentView {
    private func OnboardingProgressView(onboardingState: Binding<Int>) -> some View {
        let totalSteps = 6
        
        return VStack {
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray3)
                    .frame(width: 334, height: 4)
                    .cornerRadius(1.0)
                Rectangle()
                    .foregroundColor(.bluePurpleLine)
                    .frame(width: CGFloat(onboardingState.wrappedValue) / CGFloat(totalSteps) * 334, height: 4)
                    .cornerRadius(10.0)
                    .animation(.spring())
            }
        }
    }
}


#Preview {
    OnboardingContentView()
}
