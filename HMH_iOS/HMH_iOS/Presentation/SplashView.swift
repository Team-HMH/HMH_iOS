//
//  SplashView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 4/11/24.
//

import SwiftUI

struct SplashView: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack {}
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.bluePurpleLine, ignoresSafeAreaEdges: .all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    isLoading.toggle()
                })
            }
    }
}

