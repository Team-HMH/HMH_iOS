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
    private var OnboardingState = OnboardingViewModel().OnboardingState
    
    var body: some View {
        VStack {
            OnboardingProgressView(onboardingState: $OnboardingState)
            SurveyContainerView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            NextButtonView(onboardingState : $OnboardingState)
        }
        .padding(.horizontal, 20)
        .background(.blackground, ignoresSafeAreaEdges: .all)
    }
}

extension OnboardingContentView {
    private func OnboardingProgressView(onboardingState: Binding<Int>) -> some View {
        VStack {
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray3)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .frame(height: 4)
                    .cornerRadius(1.0)
                Rectangle()
                    .foregroundColor(.bluePurpleLine)
                    .frame(width: CGFloat(onboardingState.wrappedValue) / CGFloat(6) * 334, height: 4)
                    .cornerRadius(10.0)
                    .animation(.spring())
            }
        }
    }
    
    private func SurveyContainerView() -> some View {
        ZStack {
            switch OnboardingState {
            case 0:
                SurveyAmountView()
            case 1:
                SurveyProblemView()
            case 2:
                GoalPeriodView()
            case 3:
                GoalTimeView()
            case 4:
                PermissionView()
            case 5:
                AppSelectView()
            default:
                RoundedRectangle(cornerRadius: 25.0 )
                    .foregroundColor(.green)
            }
        }
    }
}


#Preview {
    OnboardingContentView()
}
