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
    @StateObject
    var onboardingViewModel = OnboardingViewModel(useCase: OnboardingUseCase(repository: AuthRepository(authService: AuthService(), oauthServiceFactory: OAuthServiceFactory())))
    @State private var selection = FamilyActivitySelection()
    
    var isChallengeMode: Bool
    @Environment(\.presentationMode) var presentationMode
    
    public init(isChallengeMode: Bool = false, onboardingState: Int = 0) {
        //TODO: 말썽꾸러기 스크린뷰모델
        //        let screenTimeViewModel = ScreenTimeViewModel()
        //        _screenViewModel = StateObject(wrappedValue: screenTimeViewModel)
        //        _onboardingViewModel = StateObject(wrappedValue: OnboardingViewModel(viewModel: screenTimeViewModel, onboardingState: onboardingState, isChallengeMode: isChallengeMode))
//        _onboardingViewModel = StateObject(wrappedValue: OnboardingViewModel(onboardingState: onboardingState, isChallengeMode: isChallengeMode))
        self.isChallengeMode = isChallengeMode
    }
    
    public var body: some View {
        ZStack {
            Color(DSKitAsset.blackground.swiftUIColor)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                VStack {
                    OnboardingNavigationView()
                        .frame(height: 60)
                    if !isChallengeMode {
                        OnboardingProgressView()
                    }
                }
                OnboardingTitleView()
                    .padding(.top, 31)
                Spacer()
                SurveyContainerView()
                    .frame(maxWidth: .infinity)
                Spacer()
                NextButtonView(viewModel: onboardingViewModel)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .background(DSKitAsset.blackground.swiftUIColor)
        .navigationBarHidden(true)
//        .onChange(of: onboardingViewModel.onboardingState) { newState in
//            if isChallengeMode && (newState == 1 || newState == 3 || newState == 7 ) {
//                self.presentationMode.wrappedValue.dismiss()
//                onboardingViewModel.resetOnboardingState()
//            }
//        }
//        .familyActivityPicker(isPresented: $onboardingViewModel.isPickerPresented,
//                              selection: $selection)
        .onChange(of: selection) { newSelection in
            //TODO: 말썽꾸러기 스크린뷰모델
            //            screenViewModel.updateSelectedApp(newSelection: newSelection)
//        }
//        .onChange(of: onboardingViewModel.isPickerPresented) { isPresented in
//            if !isPresented {
//                onboardingViewModel.addOnboardingState()
//                onboardingViewModel.offIsCompleted()
//            }
        }
        .onAppear() {
            //TODO: 말썽꾸러기 스크린뷰모델
            //            selection = screenViewModel.selectedApp
//            onboardingViewModel.handleOnAppear()
        }
//        .showToast(toastType: .onboardingWarn, isPresented: $onboardingViewModel.isOnboardingError)
//        .customAlert(
//            isPresented: $onboardingViewModel.isCompletePresented,
//            customAlert: {
//                CustomAlertView(
//                    alertType: .challengeCreationComplete,
//                    confirmBtn: CustomAlertButtonView(
//                        buttonType: .Confirm,
//                        alertType: .challengeCreationComplete,
//                        isPresented: $onboardingViewModel.isCompletePresented,
//                        action: {
//                            onboardingViewModel.alertAction()
//                        }
//                    ),
//                    cancelBtn: CustomAlertButtonView(
//                        buttonType: .Cancel,
//                        alertType: .challengeCreationComplete,
//                        isPresented: $onboardingViewModel.isCompletePresented,
//                        action: {
//                            onboardingViewModel.alertAction()
//                        }
//                    ), currentPoint: 0, usagePoint: 0
//                )
//            }
//        )
    }
}

extension OnboardingContentView {
    private func OnboardingNavigationView() -> some View {
        HStack {
            Button(action: {
                onboardingViewModel.send(action: .arrowButtonTap)
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
                    .frame(width: CGFloat(onboardingViewModel.state.onboardingState.rawValue) / CGFloat(5) * 334, height: 4)
                    .cornerRadius(10.0)
                    .animation(Animation.spring(duration: 0.5), value: onboardingViewModel.state.onboardingState)
            }
        }
    }
    
    private func OnboardingTitleView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(onboardingViewModel.state.onboardingState.mainTitle)
                .font(.title3_semibold_22)
                .lineSpacing(1.5)
                .foregroundStyle(DSKitAsset.whiteText.swiftUIColor)
            Text(onboardingViewModel.state.onboardingState.subTitle)
                .font(.detail1_regular_14)
                .lineSpacing(1.5)
                .foregroundStyle(DSKitAsset.gray2.swiftUIColor)
        }
    }
    
    private func SurveyContainerView() -> some View {
        VStack {
            switch onboardingViewModel.state.onboardingState {
            case .timeSurveySelect, .problemSurveySelect, .challangePeriodSelect:
                SurveyView(viewModel: onboardingViewModel)
            case .goalTimeSelect:
                AppGoalTimeView(viewModel: onboardingViewModel)
            default:
                EmptyView()
            }
        }
    }
}

