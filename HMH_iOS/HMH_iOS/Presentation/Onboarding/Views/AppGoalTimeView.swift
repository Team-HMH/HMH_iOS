//
//  AppGoalTimeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

struct AppGoalTimeView: View {
    var timesHour = Array(0...1).map { String($0) }
    var timesMinute = Array(0...59).map { String($0) }
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Spacer()
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
            .padding(.bottom, 200)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
}

