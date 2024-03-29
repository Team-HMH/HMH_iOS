//
//  OnboardingViewModel.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    
    @Published
    var surveyButtonItems: [SurveyButtonInfo]
    
    @Published
    var OnboardingState: Int
    
    @Published
    var isCompleted: Bool
    
    func addOnboardingState() {
        OnboardingState += 1
    }
    
    func toggleIsCompleted() {
        isCompleted.toggle()
    }
    
    func changeSurveyButtonStatus(num: Int) {
        for index in 0..<surveyButtonItems.count {
            if index == num {
                surveyButtonItems[index].isSelected = true
            } else {
                surveyButtonItems[index].isSelected = false
            }
        }
    }
    
    init() {
        self.surveyButtonItems = [
            SurveyButtonInfo(buttonTitle: "1-6", isSelected: false),
            SurveyButtonInfo(buttonTitle: "3-6", isSelected: false),
            SurveyButtonInfo(buttonTitle: "1-6", isSelected: false),
            SurveyButtonInfo(buttonTitle: "1-6", isSelected: false),
        ]
        self.OnboardingState = 0
        self.isCompleted = false
    }
}
