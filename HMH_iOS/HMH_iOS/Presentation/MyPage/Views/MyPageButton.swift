//
//  MyPageButton.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 4/12/24.
//

import SwiftUI

struct MyPageButton: View {
    
    @ObservedObject var viewModel: MyPageViewModel
    
    var buttonType: MyPageButtonType
    
    var body: some View {
        ZStack {
            HStack() {
                if let image = viewModel.getButtonImage(type: buttonType) {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 15)
                }
                Text(viewModel.getButtonTitle(type: buttonType))
                    .font(.text5_medium_16)
                Spacer()
                Image(buttonType == .travel ? .chevrongray : .chevronRight)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .foregroundColor(buttonType == .travel ? .gray5 : .whiteText)
        }
        .background(.blackground)
        .onTapGesture {
            viewModel.myPageButtonClick(type: buttonType)
        }
    }
}

