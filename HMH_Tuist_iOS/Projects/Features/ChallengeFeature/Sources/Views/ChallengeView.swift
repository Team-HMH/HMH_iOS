//
//  ChallengeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import SwiftUI

import DSKit

public struct ChallengeView: View {
  @ObservedObject var viewModel: ChallengeViewModel
  
  public init(viewModel: ChallengeViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    NavigationView {
      ScrollView {
        if viewModel.isChallengeExisted {
          challengeCalendarView
        } else {
          emptyChallengeHeaderView
        }
      }
      .navigationBarTitle(Text(StringLiteral.NavigationBar.challenge))
      .background(DSKitAsset.blackground.swiftUIColor)
      .showToast(toastType: .pointWarn, isPresented: $viewModel.isToastPresented)
    }
  }
}

extension ChallengeView {
  
  // MARK: - Empty View
  
  private var emptyChallengeHeaderView: some View {
    ZStack(alignment: .top) {
      Image(uiImage: DSKitAsset.challengeBackground.image)
        .resizable()
        .aspectRatio(contentMode: .fit)
      VStack(alignment: .leading) {
        Text(StringLiteral.Challenge.noChallengeTitle)
          .font(.text1_medium_22)
          .foregroundColor(DSKitAsset.whiteText.swiftUIColor)
          .padding(.top, 14)
          .padding(.leading, 23)
        Spacer()
        createChallengeButton
      }
    }
  }
  
  private var createChallengeButton: some View {
    Button(action: {
      viewModel.challengeButtonTapped()
    }) {
      Text(StringLiteral.Challenge.createButton)
        .modifier(CustomButtonStyle())
    }
  }
  
  // MARK: - Calendar
  
  private var challengeCalendarView: some View {
    ZStack(alignment: .top) {
      Image(uiImage: DSKitAsset.challengeBackground.image)
        .resizable()
        .aspectRatio(contentMode: .fit)
      VStack(alignment: .leading) {
          Text("\(viewModel.challenge.getStartDate()) 시작부터")
          .font(.text5_medium_16)
          .foregroundColor(DSKitAsset.gray1.swiftUIColor)
          .padding(.top, 14)
          Text("\((viewModel.challenge.getTodayIndex()) + 1)일차")
          .font(.title1_semibold_32)
          .foregroundColor(DSKitAsset.whiteText.swiftUIColor)
          .padding(.top, 2)
          .padding(.bottom, 32)
        HMHCalendar(
            days: viewModel.challenge.getChallengeInfo(.period),
            missionStatus: [],
            todayIndex: viewModel.challenge.getTodayIndex()
        )
          .frame(width: UIScreen.main.bounds.width * 0.9)
          .padding(.bottom, 20)
      }
    }
  }
}
