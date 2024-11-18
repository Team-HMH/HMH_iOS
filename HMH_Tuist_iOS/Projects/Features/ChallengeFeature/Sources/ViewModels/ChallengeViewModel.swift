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
    // MARK: - State
    public struct State {
        var challenge: ChallengeDetail = .init(
            statuses: [],
            todayIndex: 0,
            startDate: "",
            challengeInfo: .init(period: 0, goalTime: 0, apps: [])
        )
        var isChallengeExisted: Bool = false
        var titleString: String = ""
        var subTitleString: String = ""
        var navigateToCreate: Bool = false
        var navigateToPoint: Bool = false
        var isToastPresented: Bool = false
    }
    
    // MARK: - Action
    public enum Action {
        case fetchChallengeInfo
        case challengeButtonTapped
        case updateChallengeInfo(ChallengeDetail)
        case setToastVisibility(Bool)
        case navigateToPoint(Bool)
        case navigateToCreate(Bool)
    }
    
    // MARK: - Published State
    @Published var state: State = .init()
    
    private let challengeUseCase: ChallngeUseCaseType
    private let cancelBag: CancelBag = .init()
    
    // MARK: - Init
    public init(challengeUseCase: ChallngeUseCaseType) {
        self.challengeUseCase = challengeUseCase
    }
    
    // MARK: - Dispatch Action
    public func send(_ action: Action) {
        switch action {
        case .fetchChallengeInfo:
            fetchChallengeInfo()
        case .challengeButtonTapped:
            handleChallengeButtonTapped()
        case .updateChallengeInfo(let challenge):
            state.challenge = challenge
            checkChallengeExistence(todayIndex: challenge.getTodayIndex())
        case .setToastVisibility(let isVisible):
            state.isToastPresented = isVisible
        case .navigateToPoint(let shouldNavigate):
            state.navigateToPoint = shouldNavigate
        case .navigateToCreate(let shouldNavigate):
            state.navigateToCreate = shouldNavigate
        }
    }
    
    // MARK: - Private Methods
    private func fetchChallengeInfo() {
        challengeUseCase.getChallenge()
            .sink { _ in } receiveValue: { [weak self] challenge in
                self?.send(.updateChallengeInfo(challenge))
            }
            .store(in: cancelBag)
    }
    
    private func handleChallengeButtonTapped() {
        if state.challenge.getStatuses().contains(.unearned) {
            send(.setToastVisibility(true))
        } else {
            send(.navigateToPoint(true))
        }
    }
    
    private func checkChallengeExistence(todayIndex: Int) {
        state.isChallengeExisted = todayIndex > 0
    }
}
