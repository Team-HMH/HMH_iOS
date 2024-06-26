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
            Spacer()
                .frame(height: 64)
            ProfileView()
            Spacer()
                .frame(height: 36)
            MyInfoView()
            Spacer()
                .frame(height: 34)
            HMHInfoView()
            Spacer()
            AccountControlView()
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blackground)
    }
}

extension MyPageView {
    private func ProfileView() -> some View {
        VStack {
            Image(.profile)
                .frame(width: 54, height: 54)
                .padding(10)
            Text(viewModel.getUserName())
                .font(.title4_semibold_20)
            Spacer()
                .frame(height: 16)
            HStack {
                Text(StringLiteral.MyPageAccountControl.point)
                    .font(.text6_medium_14)
                Text(viewModel.getUserPoint())
                    .font(.text6_medium_14)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(.gray7)
            .cornerRadius(8)
        }
        .foregroundColor(.whiteText)
        .frame(width: 133, height: 150)
    }
    private func MyInfoView() -> some View {
        VStack(spacing: 0) {
            MyPageButton(viewModel: viewModel, buttonType: .travel)
            MyPageButton(viewModel: viewModel, buttonType: .market)
        }
        .background(.gray7)
    }
    private func HMHInfoView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("정보")
                .font(.text4_semibold_16)
                .foregroundColor(.gray2)
                .padding(.vertical, 14)
            MyPageButton(viewModel: viewModel, buttonType: .info)
            MyPageButton(viewModel: viewModel, buttonType: .term)
        }
    }
    private func AccountControlView() -> some View {
        HStack {
            Text(StringLiteral.MyPageAccountControl.logout)
                .font(.text6_medium_14)
            Rectangle()
                .frame(width: 1, height: 16)
            Text(StringLiteral.MyPageAccountControl.revoke)
                .font(.text6_medium_14)
        }
        .foregroundColor(.gray3)
        .frame(height: 77)
    }
}
