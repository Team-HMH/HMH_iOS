//
//  SurveyButton.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/25/24.
//

import SwiftUI

struct SurveyButton: View {
    
    var onboardingState: Int
    var numberOfRow: Int
    @StateObject
    var viewModel = OnboardingViewModel()
    @State
    var isActive = true
    
    var body: some View {
        Button {
            isActive.toggle()
        } label: {
            Text(viewModel.surveyButtonItems[numberOfRow].buttonTitle)
                .font(.text4_semibold_16)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 62)
        .foregroundColor(.whiteBtn)
        .background(isActive ? .bluePurpleOpacity22 : .gray7)
        .border(isActive ? .bluePurpleLine : .gray7, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

//#Preview {
//    SurveyButton()
//}
