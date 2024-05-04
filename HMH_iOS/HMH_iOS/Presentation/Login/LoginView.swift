//
//  LoginView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/2/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            SwipeView(imageNames: [.onboardingFirst, .onboardingFirst, .onboardingThird])
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blackground, ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    LoginView()
}

