//
//  GoalTimeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//


import SwiftUI

struct GoalTimeView: View {
    var times = ["1", "2", "3", "4", "5", "6"]
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                PickerView(times: times, selectedTimes: $viewModel.selectedGoalTime, viewModel: viewModel)
                    .frame(width: 67)
                Text("시간")
                    .font(.text2_medium_20)
                    .foregroundColor(.gray2)
            }
            .padding(.bottom, 200)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
}

