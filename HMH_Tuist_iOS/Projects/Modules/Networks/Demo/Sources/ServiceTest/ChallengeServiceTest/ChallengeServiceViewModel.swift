//
//  ChallengeServiceViewModel.swift
//  NetworksDemo
//
//  Created by 류희재 on 11/23/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine
import Core
import Networks

class ChallengeServiceViewModel: ObservableObject {
    
    //MARK: Action, State
    
    enum Action {
        case serviceButtonDidTap(Int)
    }
    
    struct State {
        var resultText: [String] = Array(repeating: "", count: 7)
        var networkLoggingText: String = "네트워크 결과창입니다!"
    }
    
    //MARK: Dependency
    
    private let service: ChallengeServiceType
    private var navigationRouter: NavigationRoutableType
    
    // MARK: - Init
    
    init(
        service: ChallengeServiceType,
        navigationRouter: NavigationRoutableType
    ) {
        self.service = service
        self.navigationRouter = navigationRouter
        self.state = State()
    }
    
    //MARK: Properties
    
    @Published private(set) var state: State
    private let cancelBag = CancelBag()
    
    //MARK: Methods
    
    func send(action: Action) {
        switch action {
        case .serviceButtonDidTap(let index):
            switch index {
            case 0:
                service.getDailyChallenge()
                    .sink(receiveCompletion: { [weak self] completion in
                        if case let .failure(error) = completion {
                            self?.state.networkLoggingText = error.description
                            self?.state.resultText[index] = "❌ 실패"
                        }
                    }) { [weak self] result in
                        self?.state.networkLoggingText = "\(result)"
                        self?.state.resultText[index] = "✅ 성공"
                    }
                    .store(in: cancelBag)
            case 1:
                service.getSuccesChallenge()
                    .sink(receiveCompletion: { [weak self] completion in
                        if case let .failure(error) = completion {
                            self?.state.networkLoggingText = error.description
                            self?.state.resultText[index] = "❌ 실패"
                        }
                    }) { [weak self] result in
                        self?.state.networkLoggingText = "\(result)"
                        self?.state.resultText[index] = "✅ 성공"
                    }
                    .store(in: cancelBag)
            case 2:
                service.createChallenge(request: .stub)
                    .sink(receiveCompletion: { [weak self] completion in
                        if case let .failure(error) = completion {
                            self?.state.networkLoggingText = error.description
                            self?.state.resultText[index] = "❌ 실패"
                        }
                    }) { [weak self] result in
                        self?.state.networkLoggingText = "\(result)"
                        self?.state.resultText[index] = "✅ 성공"
                    }
                    .store(in: cancelBag)
            case 3:
                service.postLockChallenge()
                    .sink(receiveCompletion: { [weak self] completion in
                        if case let .failure(error) = completion {
                            self?.state.networkLoggingText = error.description
                            self?.state.resultText[index] = "❌ 실패"
                        }
                    }) { [weak self] result in
                        self?.state.networkLoggingText = "\(result)"
                        self?.state.resultText[index] = "✅ 성공"
                    }
                    .store(in: cancelBag)
            case 4:
                service.deleteApp(request: .stub)
                    .sink(receiveCompletion: { [weak self] completion in
                        if case let .failure(error) = completion {
                            self?.state.networkLoggingText = error.description
                            self?.state.resultText[index] = "❌ 실패"
                        }
                    }) { [weak self] result in
                        self?.state.networkLoggingText = "\(result)"
                        self?.state.resultText[index] = "✅ 성공"
                    }
                    .store(in: cancelBag)
                
            case 5:
                service.addApp(request: .stub)
                    .sink(receiveCompletion: { [weak self] completion in
                        if case let .failure(error) = completion {
                            self?.state.networkLoggingText = error.description
                            self?.state.resultText[index] = "❌ 실패"
                        }
                    }) { [weak self] result in
                        self?.state.networkLoggingText = "\(result)"
                        self?.state.resultText[index] = "✅ 성공"
                    }
                    .store(in: cancelBag)
                
            case 6:
                service.getChallenge()
                    .sink(receiveCompletion: { [weak self] completion in
                        if case let .failure(error) = completion {
                            self?.state.networkLoggingText = error.description
                            self?.state.resultText[index] = "❌ 실패"
                        }
                    }) { [weak self] result in
                        self?.state.networkLoggingText = "\(result)"
                        self?.state.resultText[index] = "✅ 성공"
                    }
                    .store(in: cancelBag)
            default:
                break
            }
        }
    }
}
