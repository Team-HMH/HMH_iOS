//
//  MyPageView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import SwiftUI

import DSKit

public struct MyPageView_Refactor: View {
    
    
    @State private var isPresented: Bool = false
    
    public init() {}
    
    @StateObject
    var viewModel = MyPageViewModel_Refactor()
    
    public var body: some View {
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
        .background(DSKitAsset.blackground.swiftUIColor)
    }
}

extension MyPageView_Refactor {
    private func ProfileView() -> some View {
        VStack {
            Image(uiImage: DSKitAsset.profile.image)
                .frame(width: 54, height: 54)
                .padding(10)
            //TODO: 서버통신이랑 이어지는 부분이라서
//            Text(viewModel.getUserName())
//                .font(.title4_semibold_20)
            Spacer()
                .frame(height: 16)
            HStack {
                Text(StringLiteral.MyPageAccountControl.point)
                    .font(.text6_medium_14)
                //TODO: 서버통신이랑 이어지는 부분이라서
//                Text(viewModel.getUserPoint())
//                    .font(.text6_medium_14)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(DSKitAsset.gray7.swiftUIColor)
            .cornerRadius(8)
        }
        .foregroundColor(DSKitAsset.whiteText.swiftUIColor)
        .frame(width: 133, height: 150)
    }
    private func MyInfoView() -> some View {
        VStack(spacing: 0) {
            MyPageButton_Refactor(viewModel: viewModel, buttonType: .travel)
            MyPageButton_Refactor(viewModel: viewModel, buttonType: .market)
        }
        .background(DSKitAsset.gray7.swiftUIColor)
    }
    private func HMHInfoView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("정보")
                .font(.text4_semibold_16)
                .foregroundColor(DSKitAsset.gray2.swiftUIColor)
                .padding(.vertical, 14)
            MyPageButton_Refactor(viewModel: viewModel, buttonType: .info)
            MyPageButton_Refactor(viewModel: viewModel, buttonType: .term)
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
        .foregroundColor(DSKitAsset.gray3.swiftUIColor)
        .frame(height: 77)
    }
}

