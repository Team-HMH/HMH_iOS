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
    func view(showGuideView: Binding<Bool>) -> some View {
        switch self {
        case .challengeView: ChallengeView(viewModel: .init())
        case .homeView: HomeView(showGuideView: showGuideView)
        case .myPageView: MyPageView()
        }
    }
}

struct TabBarView: View {
    @State var selectedTab: Tab = .homeView
    @Binding var showGuideView: Bool
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                selectedTab.view(showGuideView: $showGuideView)
                CustomTabView(selectedTab: $selectedTab)
            }
        }
    }
    
}

#Preview {
    TabBarView(showGuideView: .constant(false))
}
