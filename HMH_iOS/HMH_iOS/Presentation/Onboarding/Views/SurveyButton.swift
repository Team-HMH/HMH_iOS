//
//  SurveyButton.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/25/24.
//

import SwiftUI

struct SurveyButton: View {
    
    var numberOfRow: Int
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        Button {
            viewModel.onIsCompleted()
            viewModel.changeSurveyButtonStatus(num: numberOfRow)
        } label: {
            Text(viewModel.surveyButtonItems[viewModel.getSurveyState()][numberOfRow].buttonTitle)
                .font(.text4_semibold_16)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 62)
        .foregroundColor(.whiteBtn)
        .background(viewModel.surveyButtonItems[viewModel.getSurveyState()][numberOfRow].isSelected ? .bluePurpleOpacity22 : .gray7)
        .border(viewModel.surveyButtonItems[viewModel.getSurveyState()][numberOfRow].isSelected ? .bluePurpleLine : .gray7, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

//#Preview {
//    SurveyButton()
//}
