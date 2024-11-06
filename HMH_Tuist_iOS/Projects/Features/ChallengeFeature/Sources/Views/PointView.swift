//
//  PointView.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/12/24.
//

import SwiftUI

import Core
import Domain
import DSKit

struct PointView: View {
    @StateObject var viewModel: PointViewModel
    
    
    public var body: some View {
        ScrollView {
            listView
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
        }
        .showToast(toastType: .earnPoint, isPresented: $viewModel.isPresented)
        .customNavigationBar(
            title: StringLiteral.NavigationBar.point,
            showBackButton: true,
            showPointButton: true,
            isPointView: true,
            point: viewModel.totalPoint
        )
        .background(DSKitAsset.blackground.swiftUIColor)
        .navigationBarHidden(true)
    }
}

extension PointView {
    private var listView: some View {
        ForEach(viewModel.pointStatues.indices, id: \.self) { index in
            HStack {
                VStack(alignment: .leading) {
                    Text("\(index + 1)" + StringLiteral.Challenge.pointTitle)
                        .font(.text4_semibold_16)
                        .foregroundColor(DSKitAsset.whiteText.swiftUIColor)
                        .padding(.bottom, 2)
                    Text("\(viewModel.period)" + StringLiteral.Challenge.pointSubTitle)
                        .font(.detail4_medium_12)
                        .foregroundColor(DSKitAsset.gray2.swiftUIColor)
                }
                Spacer()
                EarnPointButton(
                    day: index,
                    status: viewModel.pointStatus(index: index),
                    viewModel: viewModel
                )
            }
            .frame(height: 80)
        }
    }

}


struct EarnPointButton: View {
    let day: Int
    let status: PointStatusEnum // PointStatusEnum 타입으로 변경
    @ObservedObject var viewModel: PointViewModel
    
    var body: some View {
        Button(action: {
            viewModel.patchEarnPoint(index: day)
        }, label: {
            Text(StringLiteral.Challenge.pointButton + " \(viewModel.earnPoint)P")
                .font(.text4_semibold_16)
                .foregroundColor(status.titleColor) // 컬러값 설정
                .frame(width: 73, height: 40)
                .background(status.buttonColor) // 컬러값 설정
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 3, height: 3)))
        })
        .disabled(status != .unearned) // 상태에 따라 버튼 활성화 설정
    }
}
