//
//  HMHCalendar.swift
//  DSKit
//
//  Created by 이지희 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI

/// 챌린지탭의 캘린더
public struct HMHCalendar: View {
  private var days: Int
  private var missionStatus: [AchievementStatusType]
  private var todayIndex: Int
  
  
  /// initalizer : 캘린더 생성을 위한 값 세팅
  /// - Parameter :
  /// `days`:  설정한 챌린지 일자
  /// `missionStatus` : 미션 현황 (변환하여 전달)
  /// `todayIndex` : n일째에 해당
  public init (
    days: Int,
    missionStatus: [AchievementStatusType],
    todayIndex: Int
  ) {
    self.days = days
    self.missionStatus = missionStatus
    self.todayIndex = todayIndex
  }
  
  public var body: some View {
    challengeWeekView
  }
  
  var challengeWeekView: some View {
    VStack(alignment: .leading) {
      ForEach (1 ..< calculateWeekday(days: days)) { // 경고 수정 필요
        challengeWeekRow(week: $0)
      }
    }
  }
  
  @ViewBuilder
  private func challengeWeekRow(week: Int) -> some View {
    HStack {
      ForEach(1...7, id: \.self) { day in
        challengeDayCell(week: week, day: day)
      }
    }
    .padding(.bottom, 8)
  }
  
  @ViewBuilder
  private func challengeDayCell(week: Int, day: Int) -> some View {
    let index =  calculateIndex(week, day)
    if index < missionStatus.count {
      VStack {
        Text("\(index + 1)")
          .font(.text6_medium_14)
          .foregroundStyle(DSKitAsset.gray2.swiftUIColor)
        ZStack {
          Circle()
            .stroke( strokeColor(index), lineWidth: 2)
            .frame(width: 44, height: 44)
          switch missionStatus[index] {
          case .fail:
            Image(uiImage: DSKitAsset.failStar.image)
              .resizable()
              .frame(width: 24, height: 24)
          case .earned:
            Image(uiImage: DSKitAsset.doneStar.image)
          case .unearned:
            let gradient = LinearGradient(
              gradient: Gradient(stops: [
                .init(color: DSKitAsset.bluePurpleButton.swiftUIColor.opacity(0), location: 0),
                .init(color: DSKitAsset.bluePurpleButton.swiftUIColor.opacity(0.4), location: 1)
              ]),
              startPoint: .top,
              endPoint: .bottom
            )
            gradient
              .mask(Circle().frame(width: 44, height: 44))
              .frame(width: 44, height: 44)
            Image(uiImage: DSKitAsset.successStar.image)
              .resizable()
              .frame(width: 24, height: 24)
          default:
            EmptyView()
          }
        }
      }
    }
  }
}

extension HMHCalendar {
  private func calculateWeekday(days: Int) -> Int {
    return (days + 6) / 7
  }
  
  private func calculateIndex(_ week: Int, _ day: Int) -> Int {
    return (week - 1) * 7 + day - 1
  }
  
  private func strokeColor(_ index: Int) -> Color {
    return todayIndex == index ? DSKitAsset.bluePurpleOpacity70.swiftUIColor : DSKitAsset.gray6.swiftUIColor
  }
}
