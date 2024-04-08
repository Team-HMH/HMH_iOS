//
//  AppGoalTimeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

struct AppGoalTimeView: View {
    var timesHour = Array(0...23).map { String($0) }
    var timesMinute = Array(0...59).map { String($0) }
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        HStack {
            PickerView(times: timesHour, selectedTimes: $viewModel.selectedAppHour, viewModel: viewModel)
                .frame(width: 67)
            Text("시간")
                .font(.text2_medium_20)
                .foregroundColor(.gray2)
            PickerView(times: timesMinute, selectedTimes: $viewModel.selectedAppMinute, viewModel: viewModel)
                .frame(width: 67)
            Text("분")
                .font(.text2_medium_20)
                .foregroundColor(.gray2)
        }
    }
}

