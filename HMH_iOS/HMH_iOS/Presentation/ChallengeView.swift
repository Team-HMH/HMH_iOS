//
//  ChallengeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import SwiftUI

struct ChallengeView: View {
    var body: some View {
        Text("Challenge")
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green)

        .customNavigationBar(title: "챌린지", showBackButton: false, showPointButton: true)
    }
}

#Preview {
    ChallengeView()
}
