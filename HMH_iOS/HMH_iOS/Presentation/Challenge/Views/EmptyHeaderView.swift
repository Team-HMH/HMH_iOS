//
//  EmptyHeaderView.swift
//  HMH_iOS
//
//  Created by 이지희 on 7/31/24.
//

import Foundation

import SwiftUI

struct EmptyChallengeHeaderView: View {
    @ObservedObject var viewModel: ChallengeViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Image(.challengeBackground)
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text(StringLiteral.Challenge.noChallengeTitle)
                    .font(.text1_medium_22)
                    .lineSpacing(22 * 1.5 - 22)
                    .foregroundStyle(.whiteText)
                    .padding(.top, 14)
                    .padding(.leading, 23)
                Spacer()
                createChallengeButton
            }
        }
    }
    
    var createChallengeButton: some View {
        Button(action: {
            viewModel.challengeButtonTapped()
        }, label: {
            Text(StringLiteral.Challenge.createButton)
                .modifier(CustomButtonStyle())
        })
    }
}

struct EmptyChallengeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyChallengeHeaderView(viewModel: ChallengeViewModel())
    }
}
