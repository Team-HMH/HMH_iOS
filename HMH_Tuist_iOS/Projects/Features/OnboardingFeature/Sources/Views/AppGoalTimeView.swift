//
//  AppGoalTimeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

import DSKit

struct AppGoalTimeView: View {
    var timesHour = Array(0...1).map { String($0) }
    var timesMinute = Array(0...59).map { String($0) }
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            HStack {
                PickerView(times: timesHour, selectedTimes: $viewModel.selectedAppHour)
                    .frame(width: 67)
                Text("시간")
                    .font(.text2_medium_20)
                    .foregroundColor(DSKitAsset.gray2.swiftUIColor)
                PickerView(times: timesMinute, selectedTimes: $viewModel.selectedAppMinute)
                    .frame(width: 67)
                Text("분")
                    .font(.text2_medium_20)
                    .foregroundColor(DSKitAsset.gray2.swiftUIColor)
            }
        }
        .padding(.bottom, 150)
    }
}

