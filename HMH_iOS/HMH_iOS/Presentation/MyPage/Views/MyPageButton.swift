//
//  MyPageButton.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 4/12/24.
//

import SwiftUI

struct MyPageButton: View {
    
    var title: String
    var imageName: String?
    
    var body: some View {
        ZStack {
            HStack() {
                if let imageName = imageName {
                     Image(imageName)
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 24, height: 24)
                         .padding(.leading, 15)
                }
                Text("우주 상점")
                    .foregroundColor(.whiteText)
                    .font(.text5_medium_16)
                Spacer()
                Image(.chevronLeft)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .padding(.horizontal, 15)
        }
        .background(.blackground)
    }
}

#Preview {
    MyPageButton(title: "", imageName: "home")
}
