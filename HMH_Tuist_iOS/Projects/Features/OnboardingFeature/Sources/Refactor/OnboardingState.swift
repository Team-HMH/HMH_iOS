//
//  OnboardingState.swift
//  OnboardingFeature
//
//  Created by Seonwoo Kim on 11/23/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import DSKit

enum OnboardingState: Int {
    case timeSurveySelect = 0
    case problemSurveySelect
    case challangePeriodSelect
    case goalTimeSelect
    case permissionSelect
}

extension OnboardingState {
    var mainTitle: String {
        switch self {
        case .timeSurveySelect:
            return StringLiteral.OnboardigMain.timeSurveySelect
        case .problemSurveySelect:
            return StringLiteral.OnboardigMain.problemSurveySelect
        case .challangePeriodSelect:
            return StringLiteral.OnboardigMain.periodSelect
        case .permissionSelect:
            return StringLiteral.OnboardigMain.permissionSelect
        case .goalTimeSelect:
            return StringLiteral.OnboardigMain.appGoalTimeSelect
        }
    }

    var subTitle: String {
        switch self {
        case .timeSurveySelect:
            return ""
        case .problemSurveySelect:
            return StringLiteral.OnboardigSub.problemSurveySelect
        case .challangePeriodSelect:
            return StringLiteral.OnboardigSub.periodSelect
        case .permissionSelect:
            return StringLiteral.OnboardigSub.permissionSelect
        case .goalTimeSelect:
            return StringLiteral.OnboardigSub.appGoalTimeSelect
        }
    }

    var nextButtonTitle: String {
        switch self {
        case .timeSurveySelect, .problemSurveySelect, .challangePeriodSelect, .goalTimeSelect:
            return StringLiteral.OnboardingButton.next
        case .permissionSelect:
            return StringLiteral.OnboardingButton.permission
        }
    }
}

