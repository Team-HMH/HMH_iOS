//
//  OnboardingViewModel_Refactor.swift
//  OnboardingFeatureInterface
//
//  Created by Seonwoo Kim on 11/18/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

import Core
import Domain
import DSKit

public final class OnboardingViewModel : ObservableObject {
    
    private let useCase: OnboardingUseCaseType
    private var cancelBag = CancelBag()
    
    @Published private(set) var state = State(onboardingState: .timeSurveySelect, surveyButtonItems: [[]], isNextAvailable: false, surveyState: 0)
    @Published
    var selectedAppHour: String
    @Published
    var selectedAppMinute: String
    
    var userName: String
    var averageUseTime: String
    var problems: [String]
    var period: Int
    var appGoalTime: Int
    
    public init(useCase: OnboardingUseCaseType) {
        self.useCase = useCase
        self.state = State(
            onboardingState: .timeSurveySelect,
            surveyButtonItems: SurveyButtonInfo.initializeSurveyButtonItems(),
            isNextAvailable: false,
            surveyState: 0
        )
        self.userName = ""
        self.averageUseTime = ""
        self.problems = []
        self.period = 0
        self.selectedAppHour = ""
        self.selectedAppMinute = ""
        self.appGoalTime = 0
    }
    
    // MARK: Action
    
    enum Action {
        case nextButtonTap
        case arrowButtonTap
        case surveyButtonTap(index: Int)
    }
    
    // MARK: State
    
    struct State {
        var onboardingState: OnboardingState
        var surveyButtonItems: [[SurveyButtonInfo]]
        var isNextAvailable: Bool
        var surveyState: Int
    }
    
    func send(action: Action) {
        switch action {
        case .nextButtonTap:
            handleNextButtonTap()
        case .arrowButtonTap:
            handleBackButtonTap()
        case .surveyButtonTap(index: let index):
            surveyButtonTap(index: index)
        }
    }
    
    func surveyButtonTap(index: Int) {
        guard state.onboardingState.rawValue < state.surveyButtonItems.count else { return }
        
        let currentSurveyItems = state.surveyButtonItems[state.onboardingState.rawValue]
        
        switch state.onboardingState {
        case .timeSurveySelect, .challangePeriodSelect, .goalTimeSelect:
            for i in 0..<currentSurveyItems.count {
                state.surveyButtonItems[state.onboardingState.rawValue][i].isSelected = (i == index)
            }
            
            onIsCompleted()
            
        case .problemSurveySelect:
            let selectedCount = currentSurveyItems.filter { $0.isSelected }.count
            
            if currentSurveyItems[index].isSelected {
                state.surveyButtonItems[state.onboardingState.rawValue][index].isSelected = false
            } else if selectedCount < 2 {
                state.surveyButtonItems[state.onboardingState.rawValue][index].isSelected = true
            }
            
            state.isNextAvailable = state.surveyButtonItems[state.onboardingState.rawValue].contains { $0.isSelected }
            
        default:
            break
        }
    }
        
    private func resetSelections(for state: OnboardingState) {
        guard state.rawValue < self.state.surveyButtonItems.count else { return }
        for i in 0..<self.state.surveyButtonItems[state.rawValue].count {
            self.state.surveyButtonItems[state.rawValue][i].isSelected = false
        }
    }
    
    
    private func handleNextButtonTap() {
        switch state.onboardingState {
        case .timeSurveySelect:
            saveTimeSurvey()
        case .problemSurveySelect:
            saveProblemSurvey()
        case .challangePeriodSelect:
            savePeriod()
        case .goalTimeSelect:
            saveGoalTime()
        case .permissionSelect:
            savePermission()
        }
    }
    
    private func saveTimeSurvey() {
        for index in 0..<4{
            if state.surveyButtonItems[state.onboardingState.rawValue][index].isSelected {
                self.averageUseTime = state.surveyButtonItems[state.onboardingState.rawValue][index].buttonTitle
            }
        }
        addOnboardingState()
        offIsCompleted()
    }
    
    private func saveProblemSurvey() {
        for index in 0..<4{
            if state.surveyButtonItems[state.onboardingState.rawValue][index].isSelected {
                self.problems.append(state.surveyButtonItems[state.onboardingState.rawValue][index].buttonTitle)
            }
        }
        addOnboardingState()
        offIsCompleted()
    }
    
    private func savePeriod() {
        for index in 0..<4{
            if state.surveyButtonItems[state.onboardingState.rawValue] [index].isSelected {
                self.period = removeLastCharacterAndConvertToInt(from: state.surveyButtonItems[state.onboardingState.rawValue] [index].buttonTitle) ?? 0
            }
        }
        addOnboardingState()
    }
    
    private func saveGoalTime() {
        self.appGoalTime = convertToTotalMilliseconds(hour: selectedAppHour, minute: selectedAppMinute)
        addOnboardingState()
    }
    
    private func savePermission() {
        //            screenViewModel.requestAuthorization()
        //            if screenViewModel.authorizationCenter.authorizationStatus == .approved {
        //                onboardingState += 1
        //            }
        completOnboarding()
    }
    
    private func convertToTotalMilliseconds(hour: String?, minute: String?) -> Int {
        let hourInt = Int(hour ?? "") ?? 0
        let minuteInt = Int(minute ?? "") ?? 0
        
        let totalMinutes = hourInt * 60 + minuteInt
        let totalMilliseconds = totalMinutes * 60 * 1000
        return totalMilliseconds
    }
    
    private func addOnboardingState() {
        guard let nextState = OnboardingState(rawValue: state.onboardingState.rawValue + 1) else { return }
        state.onboardingState = nextState
        
        if nextState.rawValue <= 2 {
            state.surveyState = nextState.rawValue
        }
    }
    
    
    private func removeLastCharacterAndConvertToInt(from string: String) -> Int? {
        guard !string.isEmpty else {
            return nil
        }
        
        let modifiedString = String(string.dropLast())
        
        return Int(modifiedString)
    }
    
    private func handleBackButtonTap() {
        switch state.onboardingState {
        case .timeSurveySelect:
            UserManager.shared.appStateString = "login"
            offIsCompleted()
        case .problemSurveySelect, .challangePeriodSelect, .goalTimeSelect:
            guard let previousState = OnboardingState(rawValue: state.onboardingState.rawValue - 1) else { return }
            state.onboardingState = previousState
            state.surveyState = previousState.rawValue
            resetSelections(for: previousState)
            offIsCompleted()
        default:
            guard let previousState = OnboardingState(rawValue: state.onboardingState.rawValue - 1) else { return }
            state.onboardingState = previousState
            onIsCompleted()
        }
        
        print(state.onboardingState.rawValue)
    }
    
    
    private func offIsCompleted() {
        state.isNextAvailable = false
    }
    
    private func onIsCompleted() {
        state.isNextAvailable = true
    }
    
    private func completOnboarding() {
        useCase.postSignUpData(socialPlatform: "KAKAO", userName: "", averageUseTime: averageUseTime, problems: problems, period: period)
            .sink(receiveCompletion: { _ in }) {
            }
            .store(in: cancelBag)
    }
    
}
