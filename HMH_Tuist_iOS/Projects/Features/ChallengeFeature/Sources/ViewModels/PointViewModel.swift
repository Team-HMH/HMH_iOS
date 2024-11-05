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
    @Published var pointStatues: [PointStatuse] = []
    @Published var isPresented = false
    @Published var earnPoint = 0
    @Published var totalPoint = 0
    
    private var cancelBag = CancelBag()
    
    // MARK: Usecase 주입
    private let fetchPointInfoUseCase: FetchPointInfoUseCase
    private let fetchUsagePointUseCase: FetchUsagePointUseCase
    private let fetchTotalPointUseCase: FetchTotalPointUseCase
    private let usePointUseCase: UsePointUseCase
    private let earnPointUseCase: EarnPointUseCase
    
    init(
        fetchPointInfoUseCase: FetchPointInfoUseCase,
        fetchUsagePointUseCase: FetchUsagePointUseCase,
        fetchTotalPointUseCase: FetchTotalPointUseCase,
        usePointUseCase: UsePointUseCase,
        earnPointUseCase: EarnPointUseCase
    ) {
        self.fetchPointInfoUseCase = fetchPointInfoUseCase
        self.fetchUsagePointUseCase = fetchUsagePointUseCase
        self.fetchTotalPointUseCase = fetchTotalPointUseCase
        self.usePointUseCase = usePointUseCase
        self.earnPointUseCase = earnPointUseCase
    }
    
    
    func getEarnPoint() {
        fetchUsagePointUseCase.execute()
            .sink { _ in } receiveValue: { [weak self] point in
                self?.earnPoint = point
            }
            .store(in: cancelBag)
    }
    
    func patchEarnPoint(index: Int) {
        let point = pointStatues[index]
        
        earnPointUseCase.execute(point: point)
            .sink(receiveCompletion: { _ in }) { point in
                print("point \(point)")
            }
            .store(in: cancelBag)
    }
    
    func getPointList() {
        fetchPointInfoUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { [weak self] statues in
                self?.pointStatues = statues
            }
            .store(in: cancelBag)
    }
    
    func getCurrentPoint() {
        fetchTotalPointUseCase.execute()
            .sink(receiveCompletion: {_ in }) { [weak self] totalPoint in
                self?.totalPoint = totalPoint
                UserDefaults.standard.set(totalPoint, forKey: "totalPoint")
            }
            .store(in: cancelBag)
    }
}
