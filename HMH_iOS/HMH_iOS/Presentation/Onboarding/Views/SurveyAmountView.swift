//
//  SurveyAmountView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

struct SurveyAmountView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text(StringLiteral.OnboardigMain.goalTimeSelect)
                    .font(.title3_semibold_22)
                    .foregroundStyle(.whiteText)
                Text(StringLiteral.OnboardigSub.goalTimeSelect)
                    .font(.detail1_regular_14)
                    .foregroundStyle(.gray2)
            }
            Spacer(minLength: 0)
                .frame(height: 61)
            VStack(spacing: 8) {
                ForEach(0..<4) { item in
                    SurveyButton(numberOfRow: item, viewModel: viewModel)
                }
            }
        }
    }
}
//
//#Preview {
//    SurveyAmountView()
//}
