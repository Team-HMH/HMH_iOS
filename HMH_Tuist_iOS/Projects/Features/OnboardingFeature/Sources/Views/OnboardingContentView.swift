//
//  OnboardingContentView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI
import FamilyControls

import DSKit
import Core
import Data
import Networks

public struct OnboardingContentView: View {
    
    //TODO: 말썽꾸러기 스크린뷰모델
    //    @StateObject var screenViewModel = ScreenTimeViewModel()
    @ObservedObject
    var viewModel: OnboardingViewModel
//    @State private var selection: FamilyActivitySelection
    
    public init(viewModel: OnboardingViewModel) {
      self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            Color(DSKitAsset.blackground.swiftUIColor)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                VStack {
                    OnboardingNavigationView()
                        .frame(height: 60)
                    OnboardingProgressView()
                }
                OnboardingTitleView()
                    .padding(.top, 31)
                Spacer()
                SurveyContainerView()
                    .frame(maxWidth: .infinity)
                Spacer()
                NextButtonView(viewModel: viewModel)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .background(DSKitAsset.blackground.swiftUIColor)
        .navigationBarHidden(true)
    }
}

extension OnboardingContentView {
    private func OnboardingNavigationView() -> some View {
        HStack {
            Button(action: {
                viewModel.send(action: .arrowButtonTap)
            }, label: {
                Image(uiImage: DSKitAsset.chevronLeft.image)
                    .frame(width: 24, height: 24)
            })
            Spacer()
            
        }
    }
    
    private func OnboardingProgressView() -> some View {
        VStack {
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(DSKitAsset.gray3.swiftUIColor)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .frame(height: 4)
                    .cornerRadius(1.0)
                Rectangle()
                    .foregroundColor(DSKitAsset.bluePurpleLine.swiftUIColor)
                    .frame(width: CGFloat(viewModel.state.onboardingState.rawValue) / CGFloat(5) * 334, height: 4)
                    .cornerRadius(10.0)
                    .animation(Animation.spring(duration: 0.5), value: viewModel.state.onboardingState)
            }
        }
    }
    
    private func OnboardingTitleView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.state.onboardingState.mainTitle)
                .font(DSKitFontFamily.Pretendard.semiBold.swiftUIFont(size: 22))
                .lineSpacing(1.5)
                .foregroundStyle(DSKitAsset.whiteText.swiftUIColor)
            Text(viewModel.state.onboardingState.subTitle)
                .font(DSKitFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                .lineSpacing(1.5)
                .foregroundStyle(DSKitAsset.gray2.swiftUIColor)
        }
    }
    
    private func SurveyContainerView() -> some View {
        VStack {
            switch viewModel.state.onboardingState {
            case .timeSurveySelect, .problemSurveySelect, .challangePeriodSelect:
                SurveyView(viewModel: viewModel)
            case .goalTimeSelect:
                AppGoalTimeView(viewModel: viewModel)
            default:
                EmptyView()
            }
        }
    }
}

