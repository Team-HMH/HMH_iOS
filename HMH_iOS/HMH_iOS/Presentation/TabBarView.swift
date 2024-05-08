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
        case .challengeView: ChallengeView(viewModel: .init())
        case .homeView: HomeView()
        case .myPageView: MyPageView()
        }
    }
}

struct TabBarView: View {
    @State var selectedTab: Tab = .homeView
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                selectedTab.view
                CustomTabView(selectedTab: $selectedTab)
            }
        }
    }
    
}


#Preview {
    TabBarView()
}
