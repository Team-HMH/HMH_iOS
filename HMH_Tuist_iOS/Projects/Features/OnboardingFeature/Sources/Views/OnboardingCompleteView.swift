//
//  OnboardingCompleteView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 4/8/24.
//

import SwiftUI

import DSKit

public struct OnboardingCompleteView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 8) {
                    Spacer()
                    Image(uiImage: DSKitAsset.signUpComplete.image)
                    Spacer()
                        .frame(height: 25)
                    Text(StringLiteral.OnboardingComplete.title)
                        .font(.title3_semibold_22)
                        .lineSpacing(1.5)
                        .foregroundStyle(DSKitAsset.whiteText.swiftUIColor)
                    Text(StringLiteral.OnboardingComplete.subTitle)
                        .font(.detail1_regular_14)
                        .lineSpacing(1.5)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(DSKitAsset.gray2.swiftUIColor)
                }
                Spacer()
                    .frame(height: 217)
                CompleteButtonView()
            }
            .padding(20)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(DSKitAsset.blackground.swiftUIColor, ignoresSafeAreaEdges: .all)
        }
    }
}

extension OnboardingCompleteView {
    public func CompleteButtonView() -> some View {
        VStack {
            NavigationLink(destination: StoryContentView()) {
                Text(StringLiteral.OnboardingComplete.button)
                    .font(.text4_semibold_16)
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .foregroundColor(DSKitAsset.whiteBtn.swiftUIColor)
            .background(DSKitAsset.bluePurpleButton.swiftUIColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
        }
        
    }
}

#Preview {
    OnboardingCompleteView()
}

