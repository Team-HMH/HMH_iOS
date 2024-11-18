//
//  PointViewModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/12/24.
//

import Foundation

import Core
import Domain

final class PointViewModel: ObservableObject {
    
    // MARK: - State
    public struct State {
        var period: Int = 0
        var pointStatues: [PointStatuse] = []
        var isPresented: Bool = false
        var earnPoint: Int = 0
        var totalPoint: Int = 0
    }
    
    // MARK: - Action
    public enum Action {
        case setEarnPoint(Int)
        case setTotalPoint(Int)
        case setPointStatues([PointStatuse])
        case setPeriod(Int)
        case setToastPresented(Bool)
    }
    
    @Published var state = State()
    
    
    private var cancelBag = CancelBag()
    private let pointUseCase: PointUseCaseType
    
    init(pointUseCase: PointUseCaseType) {
        self.pointUseCase = pointUseCase
        loadInitialData()
    }
    
    private func loadInitialData() {
        getEarnPoint()
        getPointList()
        getCurrentPoint()
    }
    
    // MARK: - Actions
    func send(_ action: Action) {
        switch action {
        case .setEarnPoint(let point):
            state.earnPoint = point
        case .setTotalPoint(let totalPoint):
            state.totalPoint = totalPoint
            UserDefaults.standard.set(totalPoint, forKey: "totalPoint")
        case .setPointStatues(let statues):
            state.pointStatues = statues
        case .setPeriod(let period):
            state.period = period
        case .setToastPresented(let isPresented):
            state.isPresented = isPresented
        }
    }
    
    // MARK: - UseCase Call
    
     func patchEarnPoint(index: Int) {
        let point = state.pointStatues[index]
        
        pointUseCase.earnPoint(point: point)
            .sink(receiveCompletion: { _ in }) { point in
                print("point \(point)")
            }
            .store(in: cancelBag)
    }
    
    func pointStatus(index: Int) -> PointStatusEnum {
        return state.pointStatues[index].getStatus()
    }
    
    private func getEarnPoint() {
        pointUseCase.getEarnPoint()
            .sink { _ in } receiveValue: { [weak self] point in
                self?.send(.setEarnPoint(point))
            }
            .store(in: cancelBag)
    }
    
    private func getPointList() {
        pointUseCase.getPointStatues()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { [weak self] statues in
                self?.send(.setPointStatues(statues))
                self?.send(.setPeriod(statues.count))
            }
            .store(in: cancelBag)
    }
    
    private func getCurrentPoint() {
        pointUseCase.getUsagePoint()
            .sink(receiveCompletion: {_ in }) { [weak self] totalPoint in
                self?.send(.setTotalPoint(totalPoint))
            }
            .store(in: cancelBag)
    }
    
}
