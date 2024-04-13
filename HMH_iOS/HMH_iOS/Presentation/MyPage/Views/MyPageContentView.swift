//
//  MyPageContentView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 4/12/24.
//

import SwiftUI

struct MyPageContentView: View {
    
    @StateObject
    var viewModel = MyPageViewModel()
    
    var body: some View {
        VStack {
            ProfileView()
            MyInfoView()
            HMHInfoView()
            AccountControlView()
        }
    }
}

#Preview {
    MyPageContentView()
}

extension MyPageContentView {
    private func ProfileView() -> some View {
        VStack {}
    }
    private func MyInfoView() -> some View {
        VStack {}
    }
    private func HMHInfoView() -> some View {
        VStack {}
    }
    private func AccountControlView() -> some View {
        VStack {}
    }
    
}
