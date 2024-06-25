//
//  PointView.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/12/24.
//

import SwiftUI

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
        .background(.blackground)
        .navigationBarHidden(true)
    }
    
    private var listView: some View {
        ForEach(viewModel.pointList.indices, id: \.self) { index in
            let point = viewModel.pointList[index]
            HStack {
                VStack(alignment: .leading) {
                    Text("\(index + 1)" + StringLiteral.Challenge.pointTitle)
                        .font(.text4_semibold_16)
                        .foregroundColor(.whiteText)
                        .padding(.bottom, 2)
                    Text("\(viewModel.challengeDay)" + StringLiteral.Challenge.pointSubTitle)
                        .font(.detail4_medium_12)
                        .foregroundColor(.gray2)
                }
                Spacer()
                EarnPointButton(day: index, status: viewModel.statusList[index], viewModel: viewModel)
            }
            .frame(height: 80)
        }
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
            Text(StringLiteral.Challenge.pointButton)
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
            return .bluePurpleButton
        case "EARNED":
            return .bluePurpleOpacity22
        case "FAILURE":
            return .gray6
        case "NONE":
            return .gray7
        default:
            return .gray7
        }
    }
    
    private var buttonTextColor: Color {
        switch status {
        case "UNEARNED":
            return .whiteBtn
        case "EARNED":
            return .bluePurpleOpacity70
        case "FAILURE":
            return .gray2
        case "NONE":
            return .gray3
        default:
            return .gray3
        }
    }
}
