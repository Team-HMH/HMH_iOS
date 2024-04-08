//
//  OnboardingContentView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

struct OnboardingContentView: View {
    
    @StateObject
    var viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 0)
                .frame(height: 60)
            OnboardingProgressView()
            Spacer(minLength: 0)
                .frame(height: 31)
            OnboardingTitleView()
            SurveyContainerView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            NextButtonView(viewModel: viewModel)
        }
        .padding(20)
        .background(.blackground, ignoresSafeAreaEdges: .all)
    }
}

extension OnboardingContentView {
    private func OnboardingProgressView() -> some View {
        VStack {
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray3)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .frame(height: 4)
                    .cornerRadius(1.0)
                Rectangle()
                    .foregroundColor(.bluePurpleLine)
                    .frame(width: CGFloat(viewModel.onboardingState) / CGFloat(6) * 334, height: 4)
                    .cornerRadius(10.0)
                    .animation(Animation.spring(duration: 0.5), value: viewModel.onboardingState)
            }
        }
    }
    
    private func OnboardingTitleView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.getOnboardigMain())
                .font(.title3_semibold_22)
                .lineSpacing(1.5)
                .foregroundStyle(.whiteText)
            Text(viewModel.getOnboardigSub())
                .font(.detail1_regular_14)
                .lineSpacing(1.5)
                .foregroundStyle(.gray2)
        }
    }
    
    private func SurveyContainerView() -> some View {
        VStack {
            switch viewModel.onboardingState {
            case 0, 1, 2:
                SurveyView(viewModel: viewModel)
            case 3:
                GoalTimeView(viewModel: viewModel)
            case 4:
                PermissionView()
            case 5:
                AppSelectView()
            case 6:
                AppGoalTimeView(viewModel: viewModel)
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
