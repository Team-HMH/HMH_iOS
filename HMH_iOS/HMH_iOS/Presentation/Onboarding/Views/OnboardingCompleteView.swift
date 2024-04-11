//
//  OnboardingCompleteView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 4/8/24.
//

import SwiftUI

struct OnboardingCompleteView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 8) {
                    Spacer()
                    Image(.signUpComplete)
                    Spacer()
                        .frame(height: 25)
                    Text(StringLiteral.OnboardingComplete.title)
                        .font(.title3_semibold_22)
                        .lineSpacing(1.5)
                        .foregroundStyle(.whiteText)
                    Text(StringLiteral.OnboardingComplete.subTitle)
                        .font(.detail1_regular_14)
                        .lineSpacing(1.5)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.gray2)
                }
                Spacer()
                    .frame(height: 217)
                CompleteButtonView()
            }
            .padding(20)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(.blackground, ignoresSafeAreaEdges: .all)
        }
    }
}

extension OnboardingCompleteView {
    private func CompleteButtonView() -> some View {
        VStack {
            NavigationLink(destination: StoryContentView()) {
                Text(StringLiteral.OnboardingComplete.button)
                    .font(.text4_semibold_16)
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .foregroundColor(.whiteBtn)
            .background(.bluePurpleButton)
            .clipShape(RoundedRectangle(cornerRadius: 4))
        }
        
    }
}

#Preview {
    OnboardingCompleteView()
}

