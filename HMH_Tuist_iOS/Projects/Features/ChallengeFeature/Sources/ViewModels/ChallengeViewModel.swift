//
//  ChallengeViewModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/7/24.
//

import SwiftUI
import FamilyControls

import Domain
import DSKit
import Core

public final class ChallengeViewModel: ObservableObject {
    /// 챌린지 정보
    @Published var challenge: ChallengeDetail = .init(
        statuses: [],
        todayIndex: 0,
        startDate: "",
        challengeInfo: .init(period: 0, goalTime: 0, apps: [])
    )
    /// 챌린지 존재여부  - 챌린지 생성 버튼
    @Published var isChallengeExisted: Bool = false
    
    /// 뷰에 보여질 부분
    @Published var titleString = ""
    @Published var subTitleString = ""
    
    /// 뷰 이동과 관련된 코드
    @Published var navigateToCreate = false
    @Published var navigateToPoint = false
    @Published var isToastPresented = false
    
    private let cancelBag: CancelBag = .init()
    
    private let fetchChallengeUseCase: FetchChallengeUseCaseType
    
    
    public init(
        fetchChallengeUseCase: FetchChallengeUseCaseType
    ) {
        self.fetchChallengeUseCase = fetchChallengeUseCase
    }
    
    func getChallengeInfo() {
        fetchChallengeUseCase.execute()
            .sink { _ in } receiveValue: { [weak self] challenge in
                self?.challenge = challenge
                self?.checkChallengeExistence(todayIndex: challenge.getTodayIndex())
            }
            .store(in: cancelBag)
    }
    
    func challengeButtonTapped() {
        // 안 받은 포인트가 있을 때는 토스트 메시지
        if challenge.getStatuses().contains(.unearned) {
            isToastPresented = true
        } else {
            // 모든 포인트를 받았다면 navigate
            navigateToPoint = true
        }
    }
    
    func mappingCalendarData() -> [AchievementStatusType] {
        return challenge.getStatuses().map { status in
            AchievementStatusType(rawValue: status.rawValue) ?? .fail
        }
    }
    
    private func checkChallengeExistence(todayIndex: Int) {
        self.isChallengeExisted = todayIndex > 0
    }
}
