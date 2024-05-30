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
    // 앱 잠금해제시에 사용될 포인트를 조회하는 api입니다.
    
    func patchEarnPoint(day: Int) {
        let date = pointList[day].challengeDate
        let request = PointRequestDTO(challengeDate: date)
        Providers.pointProvider.request(target: .patchEarnPoint(data: request),
                                            instance: BaseResponse<EarnPointResponseDTO>.self) { result in
            guard let data = result.data else { return }
        }
    }
    // 하루하루 챌린지를 성공하고, 포인트를 받는 버튼을 눌렀을 때, 포인트를 받는 API
    
    func getPointList() {
        Providers.pointProvider.request(target: .getPointList,
                                            instance: BaseResponse<PointListResponseDTO>.self) { result in
            guard let data = result.data else { return }
            self.challengeDay = data.period
            self.currentPoint = data.point
            self.pointList = data.challengePointStatuses
        }
    }
    // 챌린지 보상 수령 여부를 리스트로 조회하는 api입니다.
    
    func patchPointUse(day: Int) {
        let date = pointList[day].challengeDate
        let request = PointRequestDTO(challengeDate: date)
        Providers.pointProvider.request(target: .patchPointUse(data: request),
                                            instance: BaseResponse<UsagePointResponseDTO>.self) { result in
            guard let data = result.data else { return }
        }
    }
    // 포인트를 사용해 이용시간 잠금을 해제할 때 사용하는 api
    
    func getCurrentPoint(date: String) {
        let request = PointRequestDTO(challengeDate: date)
        Providers.pointProvider.request(target: .getCurrentPoint(data: request),
                                            instance: BaseResponse<UserPointResponseDTO>.self) { result in
            guard let data = result.data else { return }
        }
    }
    // 현재 유저 포인트 불러오기
}
