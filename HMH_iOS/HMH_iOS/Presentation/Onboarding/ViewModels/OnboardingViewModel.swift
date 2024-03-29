//
//  OnboardingViewModel.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    
    @Published
    var surveyButtonItems: [[SurveyButtonInfo]]
    
    @Published
    var OnboardingState: Int
    
    @Published
    var isCompleted: Bool
    
    func addOnboardingState() {
        OnboardingState += 1
    }
    
    func onIsCompleted() {
        isCompleted = true
    }
    
    func offIsCompleted() {
        isCompleted = false
    }
    
    func getSurveyState() -> Int {
        return OnboardingState <= 2 ? OnboardingState : 0
    }
    
    func changeSurveyButtonStatus(num: Int) {
        for index in 0..<4{
            if index == num {
                surveyButtonItems[OnboardingState][index].isSelected = true
            } else {
                surveyButtonItems[OnboardingState][index].isSelected = false
            }
        }
    }
    
    func getOnboardigMain() -> String {
        switch OnboardingState {
        case 0:
            StringLiteral.OnboardigMain.timeSurveySelect
        case 1:
            StringLiteral.OnboardigMain.problemSurveySelect
        case 2:
            StringLiteral.OnboardigMain.periodSelect
        case 3:
            StringLiteral.OnboardigMain.goalTimeSelect
        case 4:
            StringLiteral.OnboardigMain.permissionSelect
        case 5:
            StringLiteral.OnboardigMain.appSelect
        case 6:
            StringLiteral.OnboardigSub.appGoalTimeSelect
        default:
            "error"
        }
    }
    
    func getOnboardigSub() -> String {
        switch OnboardingState {
        case 0:
            ""
        case 1:
            StringLiteral.OnboardigSub.problemSurveySelect
        case 2:
            StringLiteral.OnboardigSub.periodSelect
        case 3:
            StringLiteral.OnboardigSub.goalTimeSelect
        case 4:
            StringLiteral.OnboardigSub.permissionSelect
        case 5:
            StringLiteral.OnboardigSub.appSelect
        case 6:
            StringLiteral.OnboardigSub.appGoalTimeSelect
        default:
            "error"
        }
    }
    
    func getNextButton() -> String {
        switch OnboardingState {
        case 0:
            StringLiteral.OnboardingButton.next
        case 1:
            StringLiteral.OnboardingButton.next
        case 2:
            StringLiteral.OnboardingButton.next
        case 3:
            StringLiteral.OnboardingButton.next
        case 4:
            StringLiteral.OnboardingButton.permission
        case 5:
            StringLiteral.OnboardingButton.appSelect
        case 6:
            StringLiteral.OnboardingButton.complete
        default:
            "error"
        }
    }
    
    init() {
        self.surveyButtonItems = [
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
        self.OnboardingState = 0
        self.isCompleted = false
    }
}
