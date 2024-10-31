//
//  ChallengeViewModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/7/24.
//

import SwiftUI
import FamilyControls
import Domain

/// 추후 도메인 계층으로 분리할 모델
struct Challenge {
  let startDate: String
  let visableStartDate: String
  let todayIndex: Int
  let days: Int
  let statuses: [String]
}


public final class ChallengeViewModel: ObservableObject {
  /// 챌린지 정보
  @Published var challenge: Challenge = .init(startDate: "", visableStartDate: "", todayIndex: 0, days: 0, statuses: [])
  /// 챌린지 존재여부  - 챌린지 생성 버튼
  @Published var isChallengeExisted: Bool = false
  
  /// 뷰에 보여질 부분
  @Published var titleString = ""
  @Published var subTitleString = ""
  
  /// 뷰 이동과 관련된 코드
  @Published var navigateToCreate = false
  @Published var navigateToPoint = false
  @Published var isToastPresented = false
  

  public init() {
    getChallengeInfo()
  }
  
  func getChallengeInfo() {
    // 네트워크 요청 로직 분리 후 Challenge 데이터 처리
    // 예: challengeService.fetchChallenge() { [weak self] result in ... }
    self.isChallengeExisted = checkChallengeExistence()
  }
  
  func challengeButtonTapped() {
    // 안 받은 포인트가 있을 때는 토스트 메시지
    if challenge.statuses.contains("UNEARNED") {
      isToastPresented = true
    } else {
      // 모든 포인트를 받았다면 navigate
      navigateToPoint = true
    }
  }
  
  private func checkChallengeExistence() -> Bool {
    return challenge.days > 0
  }
}
