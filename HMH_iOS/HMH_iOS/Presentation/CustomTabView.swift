//
//  CustomTabView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import SwiftUI

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack(spacing: 30) {
            Spacer()
            TabButton(tab: .challengeView, selectedTab: $selectedTab, imageName: "calendar-check", text: "챌린지")
            Spacer()
            TabButton(tab: .homeView, selectedTab: $selectedTab, imageName: "home", text: "홈")
            Spacer()
            TabButton(tab: .myPageView, selectedTab: $selectedTab, imageName: "user", text: "마이페이지")
            Spacer()
        }
        .frame(height: 100)
        .background(Color.gray7)
    }
}

struct TabButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    let imageName: String
    let text: String
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack {
                Image(selectedImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                
                Text(text)
                    .font(.detail3_semibold_12)
            }
            .frame(width: 60, height: 49)
            .tint(selectedTab == tab ? .whiteBtn : .gray3)
        }
    }
    
    private var selectedImageName: String {
        selectedTab == tab ? imageName : "\(imageName)Unselected"
    }
}
