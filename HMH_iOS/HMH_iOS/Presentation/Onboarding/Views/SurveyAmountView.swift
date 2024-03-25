//
//  SurveyAmountView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

struct SurveyAmountView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text("안녕하세요")
                    .font(.title3_semibold_22)
                    .foregroundStyle(.whiteText)
                Text("반갑습니다. 김선우입니다.")
                    .font(.detail1_regular_14)
                    .foregroundStyle(.gray2)
            }
            Spacer(minLength: 0)
                .frame(height: 61)
            VStack(spacing: 8) {
                ForEach(0..<4) { item in
                    SurveyButton(onboardingState: 0, numberOfRow: item)
                }
            }
        }
    }
}

#Preview {
    SurveyAmountView()
}
