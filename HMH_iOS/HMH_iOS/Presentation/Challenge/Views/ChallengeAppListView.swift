//
//  ChallengeAppListView.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/6/24.
//

import SwiftUI

struct ChallengeAppListView: View {
    var body: some View {
        HStack {
            Image(systemName: "square.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.trailing, 12)
                .padding(.leading, 4)
            Text("앱 이름")
                .font(.text5_medium_16)
                .foregroundStyle(.gray2)
            Spacer()
            Text("1시간 20분")
                .font(.text6_medium_14)
                .foregroundStyle(.whiteText)
        }
        .frame(height: 72)
    }
}

#Preview {
    ChallengeAppListView()
}
