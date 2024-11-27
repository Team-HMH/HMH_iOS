//
//  MyPageView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import SwiftUI

import DSKit
import Core

public struct MyPageView: View {
    @State private var isPresented: Bool = false
    @StateObject var viewModel: MyPageViewModel
    
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
        .onAppear { viewModel.send(action: .onAppearEvent)}
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DSKitAsset.blackground.swiftUIColor)
        .customAlert(
            isPresented: $isPresented,
            customAlert: {
                CustomAlertView(
                    alertType: viewModel.state.alertType,
                    confirmBtn: CustomAlertButtonView(
                        buttonType: .Confirm,
                        alertType: viewModel.state.alertType,
                        isPresented: $isPresented,
                        action: { viewModel.send(action: .confirmButtonDidTap) }
                    ),
                    cancelBtn: CustomAlertButtonView(
                        buttonType: .Cancel,
                        alertType: viewModel.state.alertType,
                        isPresented: $isPresented,
                        action: { isPresented = false }
                    ), currentPoint: 0, usagePoint: 0
                )
            }
        )
    }
}

extension MyPageView {
    private func ProfileView() -> some View {
        VStack {
            Image(uiImage: DSKitAsset.profile.image)
                .frame(width: 54, height: 54)
                .padding(10)
            Text(viewModel.state.user.name)
                .font(.title4_semibold_20)
            Spacer()
                .frame(height: 16)
            HStack {
                Text(StringLiteral.MyPageAccountControl.point)
                    .font(.text6_medium_14)
                Text("\(viewModel.state.user.point)")
                    .font(.text6_medium_14)
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
            MyPageButton(buttonType: .travel)
            MyPageButton(buttonType: .market)
        }
        .background(DSKitAsset.gray7.swiftUIColor)
    }
    
    private func HMHInfoView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("정보")
                .font(.text4_semibold_16)
                .foregroundColor(DSKitAsset.gray2.swiftUIColor)
                .padding(.vertical, 14)
            MyPageButton(buttonType: .info)
            MyPageButton(buttonType: .term)
        }
    }
    
    private func AccountControlView() -> some View {
        HStack {
            Text(StringLiteral.MyPageAccountControl.logout)
                .font(.text6_medium_14)
                .onTapGesture {
                    isPresented = true
                    viewModel.send(action: .logoutButtonDidTap)
                }
            Rectangle()
                .frame(width: 1, height: 16)
            Text(StringLiteral.MyPageAccountControl.revoke)
                .font(.text6_medium_14)
                .onTapGesture {
                    isPresented = true
                    viewModel.send(action: .withdrawButtonDidTap)
                }
        }
        .foregroundColor(DSKitAsset.gray3.swiftUIColor)
        .frame(height: 77)
    }
}
