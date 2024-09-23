//
//  MyPageButton_Refactor.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//


import SwiftUI

import DSKit

struct MyPageButton_Refactor: View {
    
    var buttonType: MyPageButtonType_Refactor
    
    var body: some View {
        ZStack {
            HStack() {
                if let image = buttonType.imageName {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 15)
                }
                Text(buttonType.titleText)
                    .font(.text5_medium_16)
                Spacer()
                Image(uiImage: buttonType == .travel ? DSKitAsset.chevrongray.image : DSKitAsset.chevronRight.image)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .foregroundColor(buttonType == .travel ? DSKitAsset.gray5.swiftUIColor : DSKitAsset.whiteText.swiftUIColor)
        }
        .background(DSKitAsset.blackground.swiftUIColor)
        .onTapGesture {
            buttonType.clickAction
        }
    }
}


