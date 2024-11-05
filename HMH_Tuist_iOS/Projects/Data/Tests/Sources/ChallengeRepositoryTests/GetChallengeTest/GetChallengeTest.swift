//
//  GetChallengeTest.swift
//  DataTests
//
//  Created by 류희재 on 11/5/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Networks
import Core
import Domain

/// 달성현황 정보 불러오기  API  데이터 변환 테스트
extension ChallegeRepositoryTests {
    func test_달성현황정보불러오기_정상적인변환() {
        let expectedData = ChallengeDetail.expectedData
        let resultData = GetChallengeResult.resultData
        let expectation = XCTestExpectation(description: "달성현황 정보 불러오기 관련 레포지토리 변환이 정상적으로 성공했습니다!")
        
        
        mockService.getChallengeResult = Just(resultData)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
        
        sut.getChallenge()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("달성현황 정보 불러오기 API 변환 중 실패했습니다: 에러 \(error)")
                }
            }, receiveValue: valueHandler(expectation: expectation, expectedValue: expectedData))
            .store(in: cancelBag)
        
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_달성현황정보불러오기_네트워크에러발생시_에러반환() {
        
        let testCases = HMHNetworkError.mockNetworkError
        let expectation = XCTestExpectation(description: "에러 발생 시 네트워크 에러 반환")
        
        for expected in testCases {
            mockService.getChallengeResult = Fail(error: expected).eraseToAnyPublisher()
            
            sut.getChallenge()
                .sink(
                    receiveCompletion: handleCompletion(
                        expectedError: .networkError,
                        expectation: expectation
                    ),
                    receiveValue: failureExpectedValueHandler()
                )
                .store(in: cancelBag)
            
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
