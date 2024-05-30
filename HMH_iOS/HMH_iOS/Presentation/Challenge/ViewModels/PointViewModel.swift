//
//  PointViewModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/12/24.
//

import Foundation

final class PointViewModel: ObservableObject {
   @Published var challengeDay = 1
   @Published var currentPoint = 0
   @Published var pointList: [PointList] = []
    
    func getUsagePoint() {
        Providers.pointProvider.request(target: .getUsagePoint,
                                            instance: BaseResponse<UsagePointResponseDTO>.self) { result in
            guard let data = result.data else { return }
        }
    }
    
    func patchEarnPoint(day: Int) {
        let date = pointList[day].challengeDate
        let request = PointRequestDTO(challengeDate: date)
        Providers.pointProvider.request(target: .patchEarnPoint(data: request),
                                            instance: BaseResponse<EarnPointResponseDTO>.self) { result in
            guard let data = result.data else { return }
        }
    }
    
    func getPointList() {
        Providers.pointProvider.request(target: .getPointList,
                                            instance: BaseResponse<PointListResponseDTO>.self) { result in
            guard let data = result.data else { return }
            self.challengeDay = data.period
            self.currentPoint = data.point
            self.pointList = data.challengePointStatuses
        }
    }
    
    func patchPointUse(day: Int) {
        let date = pointList[day].challengeDate
        let request = PointRequestDTO(challengeDate: date)
        Providers.pointProvider.request(target: .patchPointUse(data: request),
                                            instance: BaseResponse<UsagePointResponseDTO>.self) { result in
            guard let data = result.data else { return }
        }
    }
    
    func getCurrentPoint(date: String) {
        let request = PointRequestDTO(challengeDate: date)
        Providers.pointProvider.request(target: .getCurrentPoint(data: request),
                                            instance: BaseResponse<UserPointResponseDTO>.self) { result in
            guard let data = result.data else { return }
        }
    }

}
