//
//  ChallengeActivityView.swift
//  HMHDeviceActivityReport
//
//  Created by 이지희 on 5/14/24.
//

import SwiftUI
import FamilyControls

struct ChallengeActivityView: View {
    var activityReport: ActivityReport
    
    var body: some View {
        VStack(alignment: .center) {
            ForEach(activityReport.apps) { eachApp in
                ChallengeAppListView(eachApp: eachApp)
            }
        }
    }
}

struct ChallengeAppListView: View {
    var eachApp: AppDeviceActivity
    
    var body: some View {
        HStack {
            if let token = eachApp.token {
                Label(token)
                    .labelStyle(.iconOnly)
                    .scaleEffect(2)
                    .padding(.trailing, 12)
            }
            Text(eachApp.displayName)
                .font(.text5_medium_16)
                .foregroundStyle(.gray2)
                .padding(.bottom, 1)
            Spacer()
            Text(String(eachApp.duration.toString()))
                .font(.text6_medium_14)
                .foregroundStyle(.whiteText)
        }
        .padding(.horizontal, 20)
        .frame(height: 72)
    }
}
