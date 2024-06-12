//
//  OnboardingContentView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI
import FamilyControls

struct OnboardingContentView: View {
    
    @StateObject
    var screenViewModel = ScreenTimeViewModel()
    @StateObject
    var onboardingViewModel: OnboardingViewModel
    @State private var selection = FamilyActivitySelection()
    
    var isChallengeMode: Bool
    @Environment(\.presentationMode) var presentationMode
    
    init(isChallengeMode: Bool = false, onboardingState: Int = 0) {
        let screenTimeViewModel = ScreenTimeViewModel()
        _screenViewModel = StateObject(wrappedValue: screenTimeViewModel)
        _onboardingViewModel = StateObject(wrappedValue: OnboardingViewModel(viewModel: screenTimeViewModel, onboardingState: onboardingState, isChallengeMode: isChallengeMode))
        self.isChallengeMode = isChallengeMode
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            OnboardingNavigationView()
            if !isChallengeMode {
                OnboardingProgressView()
            } else {
                
            }
            Spacer(minLength: 0)
                .frame(height: 31)
            OnboardingTitleView()
            SurveyContainerView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            NextButtonView(viewModel: onboardingViewModel)
        }
        .padding(.horizontal, 20)
        .background(.blackground, ignoresSafeAreaEdges: .all)
        .navigationBarHidden(true)
        .onChange(of: onboardingViewModel.onboardingState) { newState in
            if isChallengeMode && (newState == 1 || newState == 4 || newState == 7 ) {
                self.presentationMode.wrappedValue.dismiss()
                onboardingViewModel.resetOnboardingState()
            }
        }
        .familyActivityPicker(isPresented: $onboardingViewModel.isPickerPresented,
                              selection: $selection)
        .onChange(of: selection) { newSelection in
            screenViewModel.updateSelectedApp(newSelection: newSelection)
            if selection.rawValue != "" {
                onboardingViewModel.addOnboardingState()
            } else {
                
            }
        }
        .onAppear() {
            selection = screenViewModel.selectedApp
            onboardingViewModel.handleOnAppear()
        }
        .showToast(toastType: .onboardingWarn, isPresented: $onboardingViewModel.isOnboardingError)
        .customAlert(
            isPresented: $onboardingViewModel.isCompletePresented,
            customAlert: {
                CustomAlertView(
                    alertType: .challengeCreationComplete,
                    confirmBtn: CustomAlertButtonView(
                        buttonType: .Confirm,
                        alertType: .challengeCreationComplete,
                        isPresented: $onboardingViewModel.isCompletePresented,
                        action: {
                            onboardingViewModel.alertAction()
                        }
                    ),
                    cancelBtn: CustomAlertButtonView(
                        buttonType: .Cancel,
                        alertType: .challengeCreationComplete,
                        isPresented: $onboardingViewModel.isCompletePresented,
                        action: {
                            onboardingViewModel.alertAction()
                        }
                    ), currentPoint: 0, usagePoint: 0
                )
            }
        )

    }
}

extension OnboardingContentView {
    private func OnboardingNavigationView() -> some View {
        HStack {
            Button(action: {
                onboardingViewModel.backButtonTapped()
            }, label: {
                Image(.chevronLeft)
                    .frame(width: 24, height: 24)
            })
            Spacer()
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
    
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
                    .frame(width: CGFloat(onboardingViewModel.onboardingState) / CGFloat(6) * 334, height: 4)
                    .cornerRadius(10.0)
                    .animation(Animation.spring(duration: 0.5), value: onboardingViewModel.onboardingState)
            }
        }
    }
    
    private func OnboardingTitleView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(onboardingViewModel.getOnboardigMain())
                .font(.title3_semibold_22)
                .lineSpacing(1.5)
                .foregroundStyle(.whiteText)
            Text(onboardingViewModel.getOnboardigSub())
                .font(.detail1_regular_14)
                .lineSpacing(1.5)
                .foregroundStyle(.gray2)
        }
    }
    
    private func SurveyContainerView() -> some View {
        VStack {
            switch onboardingViewModel.onboardingState {
            case 0, 1, 2:
                SurveyView(viewModel: onboardingViewModel)
            case 3:
                GoalTimeView(viewModel: onboardingViewModel)
            case 6:
                AppGoalTimeView(viewModel: onboardingViewModel)
            default:
                EmptyView()
            }
        }
    }
}

