//
//  PointView.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/12/24.
//

import SwiftUI

import Core
import DSKit

struct PointView: View {
    @StateObject var viewModel = PointViewModel()
    
    public var body: some View {
        main
            .onAppear {
                viewModel.getPointList()
            }
    }
}

extension PointView {
    private var main: some View {
        ScrollView {
            listView
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
        }
        .showToast(toastType: .earnPoint, isPresented: $viewModel.isPresented)
        .customNavigationBar(title: StringLiteral.NavigationBar.point,
                             showBackButton: true,
                             showPointButton: true,
                             isPointView: true, point: viewModel.currentPoint)
        .background(DSKitAsset.blackground.swiftUIColor)
        .navigationBarHidden(true)
    }
    
    private var listView: some View {
        Spacer()
        //TODO: 무슨 에러인지 일단 모르겟어서 고쳐봅시다
//        ForEach(viewModel.pointList.indices, id: \.self) { index in
//            let point = viewModel.pointList[index]
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("\(index + 1)" + StringLiteral.Challenge.pointTitle)
//                        .font(.text4_semibold_16)
//                        .foregroundColor(.whiteText)
//                        .padding(.bottom, 2)
//                    Text("\(viewModel.challengeDay)" + StringLiteral.Challenge.pointSubTitle)
//                        .font(.detail4_medium_12)
//                        .foregroundColor(.gray2)
//                }
//                Spacer()
//                EarnPointButton(day: index, status: viewModel.statusList[index], viewModel: viewModel)
//            }
//            .frame(height: 80)
//        }
    }
}

#Preview {
    PointView(viewModel: .init())
}
struct EarnPointButton: View {
    let day: Int
    let status: String
    @ObservedObject var viewModel: PointViewModel
    
    var body: some View {
        Button(action: {
            viewModel.patchEarnPoint(day: day)
        }, label: {
            Text(StringLiteral.Challenge.pointButton + " \(viewModel.earnPoint)P")
                .font(.text4_semibold_16)
                .foregroundStyle(buttonTextColor)
                .frame(width: 73, height: 40)
                .background(buttonColor)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 3, height: 3)))
        })
        .disabled(status != "UNEARNED")
    }
    
    private var buttonColor: Color {
        switch status {
        case "UNEARNED":
            return DSKitAsset.bluePurpleButton.swiftUIColor
        case "EARNED":
            return DSKitAsset.bluePurpleOpacity22.swiftUIColor
        case "FAILURE":
            return DSKitAsset.gray6.swiftUIColor
        case "NONE":
            return DSKitAsset.gray7.swiftUIColor
        default:
            return DSKitAsset.gray7.swiftUIColor
        }
    }
    
    private var buttonTextColor: Color {
        switch status {
        case "UNEARNED":
            return DSKitAsset.whiteBtn.swiftUIColor
        case "EARNED":
            return DSKitAsset.bluePurpleOpacity70.swiftUIColor
        case "FAILURE":
            return DSKitAsset.gray2.swiftUIColor
        case "NONE":
            return DSKitAsset.gray3.swiftUIColor
        default:
            return DSKitAsset.gray3.swiftUIColor
        }
    }
}
