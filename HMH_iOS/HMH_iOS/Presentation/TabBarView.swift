//
//  TabBarView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import SwiftUI

enum Tab: CaseIterable {
    case challengeView
    case homeView
    case myPageView

    @ViewBuilder
        var view: some View {
            switch self {
            case .challengeView: ChallengeView()
            case .homeView: HomeView()
            case .myPageView: MyPageView()
            }
        }
}

struct TabBarView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TabBarView()
}
