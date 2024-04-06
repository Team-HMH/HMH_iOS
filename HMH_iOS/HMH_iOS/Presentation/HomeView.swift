//
//  HomeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("Home")
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity) 
            .background(Color.red)
            .customNavigationBar(title: "내 이용시간",
                                 showBackButton: false,
                                 showPointButton: false)
    }
}

#Preview {
    HomeView()
}
