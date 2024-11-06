//
//  SocialLoginTest.swift
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

/// 소셜로그인  API  데이터 변환 테스트
extension AuthRepositoryTests {
    func test_소셜로그인_정상적인변환() {
        let testCases = Array(zip(Auth.expectedData, AuthResult.resultData))
        let expectation = XCTestExpectation(description: "소셜로그인 API 관련 레포지토리 변환이 정상적으로 성공했습니다!")
        expectation.expectedFulfillmentCount = testCases.count
        
        for (expectedData, resultData) in testCases {
            mockAuthService.socialLoginResult = Just(resultData)
                .setFailureType(to: HMHNetworkError.self)
                .eraseToAnyPublisher()
            
            sut.socialLogin(socialPlatform: "KAKAO")
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("소셜로그인 API 변환 중 실패했습니다: 에러 \(error)")
                    }
                }, receiveValue: valueHandler(expectation: expectation, expectedValue: expectedData))
                .store(in: cancelBag)
        }
        
        wait(for: [expectation], timeout: 1.0 * Double(testCases.count))
    }
    
    func test_소셜로그인_네트워크에러발생시_에러반환() {
        
        let testCases = HMHNetworkError.mockNetworkError
        let expectation = XCTestExpectation(description: "에러 발생 시 네트워크 에러 반환")
        
        for expected in testCases {
            mockAuthService.socialLoginResult = Fail(error: expected).eraseToAnyPublisher()
            
            sut.socialLogin(socialPlatform: "KAKAO")
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
    
    func test_회원가입_회원이아닌경우_에러반환() {
        // Given
        let message = "회원가입된 유저가 아닙니다. 회원가입을 진행해주세요."
        let networkError = HMHNetworkError.invalidResponse(.invalidStatusCode(code: 403, message: message))
        
        mockAuthService.signUpResult = Fail(error: networkError)
            .eraseToAnyPublisher()
        
        // When
        let expectedError = AuthError.unregisteredUser
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
