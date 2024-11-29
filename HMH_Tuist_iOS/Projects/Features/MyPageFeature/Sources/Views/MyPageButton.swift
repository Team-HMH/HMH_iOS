//
//  MyPageButton.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 4/12/24.
//

import SwiftUI

import DSKit

struct MyPageButton: View {
    
    var buttonType: MyPageButtonType
    
    var body: some View {
        ZStack {
            HStack() {
                if let image = buttonType.image {
                    Image(uiImage: image)
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
