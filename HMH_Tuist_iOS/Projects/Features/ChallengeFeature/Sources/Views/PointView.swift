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
      point: viewModel.currentPoint
    )
    .background(DSKitAsset.blackground.swiftUIColor)
    .navigationBarHidden(true)
  }
}

extension PointView {
  private var listView: some View {
    ForEach(viewModel.pointList, id: \.challengeDate) { point in
      HStack {
        VStack(alignment: .leading) {
          Text("\(point.challengeDate)" + StringLiteral.Challenge.pointTitle)
            .font(.text4_semibold_16)
            .foregroundColor(DSKitAsset.whiteText.swiftUIColor)
            .padding(.bottom, 2)
          Text("\(viewModel.challengeDay)" + StringLiteral.Challenge.pointSubTitle)
            .font(.detail4_medium_12)
            .foregroundColor(DSKitAsset.gray2.swiftUIColor)
        }
        Spacer()
        EarnPointButton(
          day:viewModel.pointList.firstIndex(of: point) ?? 0,
          status: point.status,
          viewModel: viewModel
        )
      }
      .frame(height: 80)
    }
  }
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
        .foregroundStyle(viewModel.configureButton(status: status).1)
        .frame(width: 73, height: 40)
        .background(viewModel.configureButton(status: status).0)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 3, height: 3)))
    })
    .disabled(status != "UNEARNED")
  }
}
