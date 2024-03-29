//
//  OnboardingContentView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

struct OnboardingContentView: View {
    
    @ObservedObject
    var viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 0)
                .frame(height: 60)
            OnboardingProgressView()
            Spacer(minLength: 0)
                .frame(height: 31)
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
            SurveyContainerView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            NextButtonView()
                .environmentObject(viewModel)
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
                    .frame(width: CGFloat(viewModel.OnboardingState) / CGFloat(6) * 334, height: 4)
                    .cornerRadius(10.0)
                    .animation(.spring())
            }
        }
    }
    
    private func SurveyContainerView() -> some View {
        VStack {
            switch viewModel.OnboardingState {
            case 0:
                SurveyAmountView(viewModel: viewModel)
            case 1:
                SurveyAmountView(viewModel: viewModel)
            case 2:
                SurveyAmountView(viewModel: viewModel)
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
