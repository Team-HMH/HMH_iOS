//
//  AppActivityView.swift
//  HMHDeviceActivityReport
//
//  Created by 이지희 on 4/27/24.
//

import SwiftUI
import FamilyControls

struct AppActivityView: View {
    var activityReport: ActivityReport
    var body: some View {
        VStack(alignment: .center) {
            ForEach(activityReport.apps) { eachApp in
                ListView(eachApp: eachApp)
                    .padding(.horizontal, 20)
            }
        }
    }
}

struct ListView: View {
    var eachApp: AppDeviceActivity
    
    var body: some View {
        HStack {
            if let token = eachApp.token {
                Label(token)
                    .labelStyle(.iconOnly)
                    .scaleEffect(2)
                    .padding(.trailing, 8)
            }
            VStack(alignment: .leading) {
                Text(eachApp.displayName)
                    .font(.detail3_semibold_12)
                    .foregroundStyle(.gray1)
                    .padding(.bottom, 1)
                Text(String(eachApp.duration.toString()))
                    .font(.detail2_semibold_13)
                    .foregroundStyle(.whiteText)
            }
            Spacer()
            Text("58분 ")
                .font(.text6_medium_14)
                .foregroundStyle(.whiteText)
            + Text("남음")
                .font(.text6_medium_14)
                .foregroundStyle(.gray2)
        }
        .padding(.horizontal, 18)
        .frame(height: 72)
        .background(backgroundView)
    }
    
    var backgroundView: some View {
        GeometryReader { geometry in
            let remainingPercent = Double(eachApp.remainTime) / 3600 // 0에서 1 사이의 값으로 정규화
            let gradientColors: [Color] = [.bluePurpleButton.opacity(0.4), .bluePurpleButton]
            
            LinearGradient(gradient: Gradient(colors: gradientColors),
                           startPoint: .leading,
                           endPoint: .trailing)
                .frame(width: geometry.size.width * CGFloat(remainingPercent))
                .clipShape(RoundedRectangle(cornerRadius: 4))
        }
    }
}
