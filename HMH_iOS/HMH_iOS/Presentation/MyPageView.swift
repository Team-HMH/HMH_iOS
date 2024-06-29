//
//  MyPageView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import SwiftUI

struct MyPageView: View {
    
    @StateObject var viewModel = MyPageViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 64)
                ProfileView(viewModel: viewModel)
                Spacer().frame(height: 36)
                MyInfoView(viewModel: viewModel)
                Spacer().frame(height: 34)
                HMHInfoView(viewModel: viewModel)
                Spacer()
                AccountControlView(viewModel: viewModel)
                NavigationLink(
                    destination: ServicePrepareView(),
                    isActive: $viewModel.navigateToPrepare,
                    label: {
                        EmptyView()
                    })
            }
            .onAppear() {
                viewModel.getUserData()
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blackground)
            .customAlert(
                isPresented: $viewModel.isPresented,
                customAlert: {
                    CustomAlertView(
                        alertType: viewModel.alertType,
                        confirmBtn: CustomAlertButtonView(
                            buttonType: .Confirm,
                            alertType: viewModel.alertType,
                            isPresented: $viewModel.isPresented,
                            action: {
                                viewModel.confirmAction()
                                
                            }
                        ),
                        cancelBtn: CustomAlertButtonView(
                            buttonType: .Cancel,
                            alertType: viewModel.alertType,
                            isPresented: $viewModel.isPresented,
                            action: {
                                viewModel.cancelAction()
                            }
                        ), currentPoint: 0, usagePoint: 0
                    )
                }
            )

        }
    }
}

extension MyPageView {
    private func ProfileView(viewModel: MyPageViewModel) -> some View {
        VStack {
            Image(.profile)
                .frame(width: 54, height: 54)
                .padding(10)
            Text(viewModel.name)
                .font(.title4_semibold_20)
            Spacer().frame(height: 16)
            HStack {
                Text(StringLiteral.MyPageAccountControl.point)
                    .font(.text6_medium_14)
                Text("\(viewModel.point)P")
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
    
    private func MyInfoView(viewModel: MyPageViewModel) -> some View {
        VStack(spacing: 0) {
            MyPageButton(viewModel: viewModel, buttonType: .travel)
            MyPageButton(viewModel: viewModel, buttonType: .market)
        }
        .background(.gray7)
    }
    
    private func HMHInfoView(viewModel: MyPageViewModel) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("정보")
                .font(.text4_semibold_16)
                .foregroundColor(.gray2)
                .padding(.vertical, 14)
            MyPageButton(viewModel: viewModel, buttonType: .info)
            MyPageButton(viewModel: viewModel, buttonType: .term)
        }
    }
    
    private func AccountControlView(viewModel: MyPageViewModel) -> some View {
        HStack(spacing: 19) {
            Button(action: {
                viewModel.logoutButtonClicked()
            }) {
                Text(StringLiteral.MyPageAccountControl.logout)
                    .font(.text6_medium_14)
            }
            .foregroundColor(.gray3)
            
            Rectangle()
                .frame(width: 1, height: 16)
            
            Button(action: {
                viewModel.withdrawButtonClicked()
            }) {
                Text(StringLiteral.MyPageAccountControl.revoke)
                    .font(.text6_medium_14)
            }
            .foregroundColor(.gray3)
        }
        .frame(height: 77)
    }
}
