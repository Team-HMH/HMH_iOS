//
//  CustomNavigationBarModifier.swift
//  HMH_iOS
//
//  Created by 이지희 on 4/1/24.
//

import SwiftUI
import SwiftUI

extension View {
    func customNavigationBar(title: String, showBackButton: Bool, showPointButton: Bool,
                             showGuideButton: Bool, isPointView: Bool = false, point: Int, showGuideView: Binding<Bool>) -> some View {
        self.modifier(CustomNavigationBarModifier(title: title, point: point,
                                                  showBackButton: showBackButton,
                                                  showPointButton: showPointButton,
                                                  showGuideButton: showGuideButton,
                                                  isPointView: isPointView,
                                                  showGuideView: showGuideView))
    }
}

struct CustomNavigationBarModifier: ViewModifier {
    let title: String
    var point: Int
    var showBackButton: Bool
    var showPointButton: Bool
    var showGuideButton: Bool
    var isPointView: Bool
    @Binding var showGuideView: Bool
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            NavigationBarView(showGuideView: $showGuideView,
                              showBackButton: showBackButton,
                              showPointButton: showPointButton,
                              showGuideButton: showGuideButton,
                              isPointView: isPointView,
                              title: title, point: point)
            content
                .toolbar(.hidden)
        }
    }
}
