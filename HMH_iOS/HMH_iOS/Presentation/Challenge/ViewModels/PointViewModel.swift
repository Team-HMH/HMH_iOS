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
    @Published var statusList: [String] = []
    @Published var isPresented = false
    
    init() {
        self.getPointList()
        self.getUsagePoint()
    }
    
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
                                        instance: BaseResponse<PatchEarnPointResponseDTO>.self) { result in
            guard let data = result.data else { return }
            self.isPresented = true
            self.statusList[day] = "EARNED"
            self.getPointList()
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
            self.pointList.forEach { point in
                self.statusList.append(point.status)
            }
        }
    }
    // 챌린지 보상 수령 여부를 리스트로 조회하는 api입니다.
    
    
    func getCurrentPoint() {
        Providers.pointProvider.request(target: .getCurrentPoint,
                                        instance: BaseResponse<UserPointResponseDTO>.self) { result in
            guard let data = result.data else { return }
            self.currentPoint = data.point
        }
    }
    // 현재 유저 포인트 불러오기
}
