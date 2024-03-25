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
    
    init() {
        self.surveyButtonItems = [
            SurveyButtonInfo(buttonTitle: "1-6", isSelected: false),
            SurveyButtonInfo(buttonTitle: "3-6", isSelected: false),
            SurveyButtonInfo(buttonTitle: "1-6", isSelected: false),
            SurveyButtonInfo(buttonTitle: "1-6", isSelected: false),
        ]
        self.OnboardingState = 0
    }
}
