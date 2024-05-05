//
//  UsageTimeListItemView.swift
//  HMH_iOS
//
//  Created by 이지희 on 4/11/24.
//

import SwiftUI

struct UsageTimeListItemView: View {
    var appName: String
    var usageTime: Int
    var remainingTime: String
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.gray7)
                .frame(minWidth: 335, maxHeight: 72)
                .padding(.horizontal)
           // Color(.bluePurpleProgress)
            //    .frame(maxWidth: 335/20, maxHeight: 72)
            HStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                VStack (alignment: .leading){
                    Text(appName)
                        .font(.detail3_semibold_12)
                        .foregroundStyle(.gray1)
                    Text(String(usageTime) + "분")
                        .font(.detail2_semibold_13)
                        .foregroundStyle(.whiteText)
                }
                Spacer()
                Text("\(remainingTime)남음")
                    .font(.text6_medium_14)
                    .foregroundStyle(.whiteText)
            }
            .frame(maxWidth: 335, minHeight: 72)
            .padding(EdgeInsets(top: 0, leading: 38, bottom: 8, trailing: 38))
        }
    }
}

#Preview {
    UsageTimeListItemView(appName: "Youtube", usageTime: 20, remainingTime: "2시간")
}
