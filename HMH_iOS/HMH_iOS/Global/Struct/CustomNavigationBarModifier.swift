//
//  CustomNavigationBarModifier.swift
//  HMH_iOS
//
//  Created by 이지희 on 4/1/24.
//

import SwiftUI

extension View {
    func customNavigationBar(title: String, showBackButton: Bool, showPointButton: Bool) -> some View {
        self.modifier(CustomNavigationBarModifier(title: title, showBackButton: showBackButton, showPointButton: showPointButton))
    }
}

struct CustomNavigationBarModifier: ViewModifier {
    let title: String
    var showBackButton: Bool
    var showPointButton: Bool
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            NavigationBarView(showBackButton: showBackButton, showPointButton: showPointButton, title: title)
            content
                .toolbar(.hidden)
        }
    }
}
