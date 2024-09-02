//
//  OnboardingAmplitudeModel.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 8/13/24.
//

import Foundation

struct OnboardingAmplitudeModel: Identifiable {
    let id = UUID()
    var averageUseTimeIndex: Int
    var problemIndex: [Int]
    var period: Int
}
