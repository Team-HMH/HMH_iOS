//
//  MyPageView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import SwiftUI

struct MyPageView: View {
    
    @StateObject
    var viewModel = MyPageViewModel()
    
    var body: some View {
        VStack {
            ProfileView()
            MyInfoView()
            HMHInfoView()
            AccountControlView()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blackground)
    }
}

#Preview {
    MyPageView()
}

extension MyPageView {
    private func ProfileView() -> some View {
        VStack {
            Image(.home)
                .frame(width: 54, height: 54)
            Text("김하면함")
                .font(.title4_semibold_20)
            HStack {
                Text("내 포인트")
                Text("100P")
            }
        }
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
