//
//  AddAppTest.swift
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

/// 스크린타임 설정할 앱 추가  API  데이터 변환 테스트
extension ChallegeRepositoryTests {
    func test_스크린타임설정할앱추가_정상적인변환() {
        
        let expectation = XCTestExpectation(description: "스크린타임 설정할 앱 추가 API 관련 레포지토리 변환이 정상적으로 성공했습니다!")
        
        mockService.addAppResult = Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
        
        sut.addApp(apps: [.stub])
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("스크린타임 설정할 앱 추가 API 변환 중 실패했습니다: 에러 \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { _ in
                expectation.fulfill()
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_스크린타임설정할앱추가_네트워크에러발생시_에러반환() {
        
        let testCases = HMHNetworkError.mockNetworkError
        let expectation = XCTestExpectation(description: "에러 발생 시 네트워크 에러 반환")
        
        for expected in testCases {
            mockService.addAppResult = Fail(error: expected).eraseToAnyPublisher()
            
            sut.addApp(apps: [.stub])
                .sink(
                    receiveCompletion: handleCompletion(
                        expectedError: .networkError,
                        expectation: expectation
                    ),
                    receiveValue: failureExpectedValueHandler()
                )
                .store(in: cancelBag)
            
        }
        
        wait(for: [expectation], timeout: 1.0 * Double(testCases.count))
    }
}
