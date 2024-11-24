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

public final class OnboardingViewModel_Refactor : ObservableObject {
    
    private let useCase: OnboardingUseCaseType
    private var cancelBag = CancelBag()
    
    @Published private(set) var state = State(onboardingState: .timeSurveySelect, surveyButtonItems: [[]], isNextAvailable: false)
    var userName: String
    var averageUseTime: String
    var problems: [String]
    var period: Int
    
    public init(useCase: OnboardingUseCaseType) {
        self.useCase = useCase
        self.state = State(
            onboardingState: .timeSurveySelect,
            surveyButtonItems: initializeSurveyButtonItems(),
            isNextAvailable: false
        )
        self.userName = ""
        self.averageUseTime = ""
        self.problems = []
        self.period = 0
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
        
        // 현재 상태에 해당하는 버튼 리스트 가져오기
        let currentSurveyItems = state.surveyButtonItems[state.onboardingState.rawValue]
        
        // index 유효성 검증
        guard index >= 0 && index < currentSurveyItems.count else { return }
        
        // 상태에 따라 다른 선택 로직 적용
        switch state.onboardingState {
        case .timeSurveySelect, .challangePeriodSelect, .goalTimeSelect:
            // 단일 선택 상태
            for i in 0..<currentSurveyItems.count {
                state.surveyButtonItems[state.onboardingState.rawValue][i].isSelected = (i == index)
            }
            // 다음 버튼 활성화
            state.isNextAvailable = true
            
        case .problemSurveySelect:
            // 다중 선택 상태: 최대 두 개의 선택만 허용
            let selectedCount = currentSurveyItems.filter { $0.isSelected }.count
            
            if currentSurveyItems[index].isSelected {
                // 이미 선택된 경우 해제
                state.surveyButtonItems[state.onboardingState.rawValue][index].isSelected = false
            } else if selectedCount < 2 {
                // 선택 가능하면 활성화
                state.surveyButtonItems[state.onboardingState.rawValue][index].isSelected = true
            }
            
            // 다음 버튼 활성화 여부 결정
            state.isNextAvailable = state.surveyButtonItems[state.onboardingState.rawValue].contains { $0.isSelected }
            
        default:
            break
        }
    }
    
    private func initializeSurveyButtonItems() -> [[SurveyButtonInfo]] {
        return [
            [
                SurveyButtonInfo(buttonTitle: StringLiteral.TimeSurveySelect.firstSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.TimeSurveySelect.secondSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.TimeSurveySelect.thirdSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.TimeSurveySelect.fourthSelect, isSelected: false),
            ],
            [
                SurveyButtonInfo(buttonTitle: StringLiteral.ProblemSurveySelect.firstSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.ProblemSurveySelect.secondSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.ProblemSurveySelect.thirdSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.ProblemSurveySelect.fourthSelect, isSelected: false),
            ],
            [
                SurveyButtonInfo(buttonTitle: StringLiteral.PeriodSelect.firstSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.PeriodSelect.secondSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.PeriodSelect.thirdSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.PeriodSelect.fourthSelect, isSelected: false),
            ]
        ]
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
                self.period = removeLastCharacterAndConvertToInt(from: state.surveyButtonItems[state.onboardingState.rawValue] [index].buttonTitle)
            }
        }
        addOnboardingState()
    }
    
    private func saveGoalTime() {
        
    }
    
    private func savePermission() {
        //            screenViewModel.requestAuthorization()
        //            if screenViewModel.authorizationCenter.authorizationStatus == .approved {
        //                onboardingState += 1
        //            }
    }
    
    private func saveApp() {
        //            screenViewModel.requestAuthorization()
        //            if screenViewModel.authorizationCenter.authorizationStatus == .approved {
        //                onboardingState += 1
        //            }
    }
    
    private func addOnboardingState() {
        state.onboardingState.rawValue += 1
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
            offIsCompleted()
        case .appSelect:
            guard let previousState = OnboardingState(rawValue: state.onboardingState.rawValue - 1) else { return }
            state.onboardingState = previousState
            offIsCompleted()
        default:
            guard let previousState = OnboardingState(rawValue: state.onboardingState.rawValue - 1) else { return }
            state.onboardingState = previousState
            onIsCompleted()
        }
    }
    
    
    private func offIsCompleted() {
        state.isNextAvailable = false
    }
    
    private func onIsCompleted() {
        state.isNextAvailable = true
    }
    
    private func completOnboarding() {
        useCase.postSignUpData(socialPlatform: <#T##String#>, userName: <#T##String#>, averageUseTime: <#T##String#>, problems: <#T##[String]#>, period: <#T##Int#>)
            .sink(receiveCompletion: { _ in }) {
            }
            .store(in: cancelBag)
    }
    
    
}

