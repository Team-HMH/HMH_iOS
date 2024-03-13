//
//  CustomTabView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack(spacing: 30) {
            Spacer()
            Button() {
                selectedTab = .challengeView
            } label: {
                VStack {
                    Image(systemName: "1.square.fill")
                    Text("챌린지")
                }
                .frame(width: 60, height: 49)
            }
            Spacer()
            Button {
                selectedTab = .homeView
            } label: {
                VStack {
                    Image(systemName: "1.square.fill")
                    Text("챌린지")
                }
                .frame(width: 60, height: 49)
                .background(Color.yellow)
            }
            Spacer()
            Button {
                selectedTab = .myPageView
            } label: {
                VStack {
                    Image(systemName: "1.square.fill")
                    Text("챌린지")
                }
                .frame(width: 60, height: 49)
            }
            Spacer()
        }
        .frame(height: 100) // Set height of the HStack
        .background(.gray) // Set background color for the HStack
    }
    
}

//    #Preview {
////        @Binding var selectedTab: Tab
//        CustomTabView(selectedTab: $selectedTab)
//    }
