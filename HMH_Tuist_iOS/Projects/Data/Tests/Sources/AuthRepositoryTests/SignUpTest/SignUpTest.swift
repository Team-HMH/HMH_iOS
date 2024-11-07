//
//  SignUpTest.swift
//  DataTests
//
//  Created by 류희재 on 11/6/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Networks
import Core
import Domain

/// 회원가입  API  데이터 변환 테스트
extension AuthRepositoryTests {
    func test_회원가입_정상적인변환() {
        let testCases = Array(zip(Auth.expectedData, AuthResult.resultData))
        let expectation = XCTestExpectation(description: "회원가입 API 관련 레포지토리 변환이 정상적으로 성공했습니다!")
        expectation.expectedFulfillmentCount = testCases.count
        
        for (expectedData, resultData) in testCases {
            mockAuthService.signUpResult = Just(resultData)
                .setFailureType(to: HMHNetworkError.self)
                .eraseToAnyPublisher()
            
            sut.signUp(socialPlatform: "KAKAO", name: "류희재", averageUseTime: "1~4", problem: ["아아아아"], challengeInfo: .init(period: 1, goalTime: 1, apps: [.stub]))
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("회원가입 API 변환 중 실패했습니다: 에러 \(error)")
                    }
                }, receiveValue: valueHandler(expectation: expectation, expectedValue: expectedData))
                .store(in: cancelBag)
        }
        
        wait(for: [expectation], timeout: 1.0 * Double(testCases.count))
    }
    
    func test_회원가입_네트워크에러발생시_에러반환() {
        
        let testCases = HMHNetworkError.mockNetworkError
        let expectation = XCTestExpectation(description: "에러 발생 시 네트워크 에러 반환")
        
        for expected in testCases {
            mockAuthService.signUpResult = Fail(error: expected).eraseToAnyPublisher()
            
            sut.signUp(socialPlatform: "KAKAO", name: "류희재", averageUseTime: "1~4", problem: ["아아아아"], challengeInfo: .init(period: 1, goalTime: 1, apps: [.stub]))
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
    
    func test_회원가입_회원가입정보가없을때_에러반환() {
        // Given
        let message = "온보딩 정보 또는 챌린지 정보 없음"
        let networkError = HMHNetworkError.invalidResponse(.invalidStatusCode(code: 400, message: message))
        
        mockAuthService.signUpResult = Fail(error: networkError)
            .eraseToAnyPublisher()
        
        // When
        let expectedError = AuthError.noSignUpInfo
        let expectation = XCTestExpectation(description: message)
        
        sut.signUp(socialPlatform: "KAKAO", name: "류희재", averageUseTime: "1~4", problem: ["아아아아"], challengeInfo: .init(period: 1, goalTime: 1, apps: [.stub]))
            .sink(
                receiveCompletion: handleCompletion(
                    expectedError: expectedError,
                    expectation: expectation
                ),receiveValue: failureExpectedValueHandler()
            )
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_회원가입_이미회원가입을했을때_에러반환() {
        // Given
        let message = "이미 회원가입된 유저입니다."
        let networkError = HMHNetworkError.invalidResponse(.invalidStatusCode(code: 400, message: message))
        
        mockAuthService.signUpResult = Fail(error: networkError)
            .eraseToAnyPublisher()
        
        // When
        let expectedError = AuthError.alreadyRegisteredUser
        let expectation = XCTestExpectation(description: message)
        
        sut.signUp(socialPlatform: "KAKAO", name: "류희재", averageUseTime: "1~4", problem: ["아아아아"], challengeInfo: .init(period: 1, goalTime: 1, apps: [.stub]))
            .sink(
                receiveCompletion: handleCompletion(
                    expectedError: expectedError,
                    expectation: expectation
                ),receiveValue: failureExpectedValueHandler()
            )
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
