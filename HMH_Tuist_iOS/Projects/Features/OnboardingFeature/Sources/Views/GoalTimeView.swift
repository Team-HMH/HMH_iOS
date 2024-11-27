//
//  GoalTimeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//


import SwiftUI

import DSKit

struct GoalTimeView: View {
    var times = ["1", "2", "3", "4", "5", "6"]
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            HStack {
                //TODO: PickerView의 위치를 다시 생각해볼 필요가 있다
//                PickerView(times: times, selectedTimes: $viewModel.selectedGoalTime, viewModel: viewModel)
//                    .frame(width: 67)
                Text("시간")
                    .font(DSKitFontFamily.Pretendard.medium.swiftUIFont(size: 20))
                    .foregroundColor(DSKitAsset.gray2.swiftUIColor)
            }
        }
        .padding(.bottom, 150)
    }
}

