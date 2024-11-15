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
    @Published var period = 0
    @Published var pointStatues: [PointStatuse] = []
    @Published var isPresented = false
    @Published var earnPoint = 0
    @Published var totalPoint = 0
    
    private var cancelBag = CancelBag()
    
    // MARK: Usecase 주입
    private let pointUseCase: PointUseCaseType
    
    init(pointUseCase: PointUseCaseType) {
        self.pointUseCase = pointUseCase
    }
    
    func getEarnPoint() {
        pointUseCase.getEarnPoint()
            .sink { _ in } receiveValue: { [weak self] point in
                self?.earnPoint = point
            }
            .store(in: cancelBag)
    }
    
    func patchEarnPoint(index: Int) {
        let point = pointStatues[index]
        
        pointUseCase.earnPoint(point: point)
            .sink(receiveCompletion: { _ in }) { point in
                print("point \(point)")
            }
            .store(in: cancelBag)
    }
    
    func getPointList() {
        pointUseCase.getPointStatues()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { [weak self] statues in
                self?.pointStatues = statues
                self?.period = statues.count
            }
            .store(in: cancelBag)
    }
    
    func getCurrentPoint() {
        pointUseCase.getUsagePoint()
            .sink(receiveCompletion: {_ in }) { [weak self] totalPoint in
                self?.totalPoint = totalPoint
                UserDefaults.standard.set(totalPoint, forKey: "totalPoint")
            }
            .store(in: cancelBag)
    }
    
    func pointStatus(index: Int) -> PointStatusEnum {
        return pointStatues[index].getStatus()
    }
}
