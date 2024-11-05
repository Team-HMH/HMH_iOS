//
//  DeleteAccountTest.swift
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

/// 회원 탈퇴 API  데이터 변환 테스트
extension UserRepositoryTests {
    func test_회원탈퇴_정상적인변환() {
        
        let expectation = XCTestExpectation(description: "회원 탈퇴 API 레포지토리 변환이 정상적으로 성공했습니다!")
        
        mockService.deleteAccountResult = Just(())
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
        
        sut.deleteAccount()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("회원 탈퇴 API 변환 중 실패했습니다: 에러 \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { _ in
                expectation.fulfill()
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_회원탈퇴_네트워크에러발생시_에러반환() {
        
        let testCases = HMHNetworkError.mockNetworkError
        let expectation = XCTestExpectation(description: "에러 발생 시 네트워크 에러 반환")
        
        for expected in testCases {
            mockService.deleteAccountResult = Fail(error: expected).eraseToAnyPublisher()
            
            sut.deleteAccount()
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
