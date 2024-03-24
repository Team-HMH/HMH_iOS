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
    
    init() {
        self.surveyButtonItems = []
    }
}
