//
//  SurveyAmountView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

struct SurveyView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(0..<4) { item in
                SurveyButton(numberOfRow: item, viewModel: viewModel)
            }
        }
        
    }
}
//
//#Preview {
//    SurveyAmountView()
//}
