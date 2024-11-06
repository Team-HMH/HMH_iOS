//
//  AutorizeTest.swift
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
import Data

/// 회원가입  API  데이터 변환 테스트
extension AuthRepositoryTests {
    func test_카카오인증처리_정상적인변환() {
        let expectedData = "Access토큰"
        let resultData = "Access토큰"
        let expectation = XCTestExpectation(description: "카카오 인증처리 관련 레포지토리 변환이 정상적으로 성공했습니다!")
        
        let kakaoService = MockOAuthKakaoService()
        kakaoService.authorizeResult = Just(resultData)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
        let mockFactory = MockOAuthServiceFactory()
        mockFactory.service = kakaoService
        
        sut = AuthRepository(authService: mockAuthService, oauthServiceFactory: mockFactory)
        
        sut.authorize(.kakao)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("카카오 인증처리 API 변환 중 실패했습니다: 에러 \(error)")
                }
            }, receiveValue: valueHandler(expectation: expectation, expectedValue: expectedData))
            .store(in: cancelBag)
        
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_카카오인증처리_에러가발생시_에러반환() {
        
        let message = "카카오 로그인 시도 중 생긴 oauth 오류입니다"
        let networkError = HMHNetworkError.oautheticationError(.kakaoLoginError)
        
        let kakaoService = MockOAuthKakaoService()
        kakaoService.authorizeResult = Fail(error: networkError)
            .eraseToAnyPublisher()
        let mockFactory = MockOAuthServiceFactory()
        mockFactory.service = kakaoService
        
        sut = AuthRepository(authService: mockAuthService, oauthServiceFactory: mockFactory)
        
        // When
        let expectedError = AuthError.kakaoAuthrizeError
        let expectation = XCTestExpectation(description: message)
        
        sut.authorize(.kakao)
            .sink(
                receiveCompletion: handleCompletion(
                    expectedError: expectedError,
                    expectation: expectation
                ),receiveValue: failureExpectedValueHandler()
            )
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_애플인증처리_정상적인변환() {
        let expectedData = "Access토큰"
        let resultData = "Access토큰"
        let expectation = XCTestExpectation(description: "애플 인증처리 관련 레포지토리 변환이 정상적으로 성공했습니다!")
        
        let appleService = MockOAuthAppleService()
        appleService.authorizeResult = Just(resultData)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
        let mockFactory = MockOAuthServiceFactory()
        mockFactory.service = appleService
        
        sut = AuthRepository(authService: mockAuthService, oauthServiceFactory: mockFactory)
        
        sut.authorize(.apple)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("애플 인증처리 API 변환 중 실패했습니다: 에러 \(error)")
                }
            }, receiveValue: valueHandler(expectation: expectation, expectedValue: expectedData))
            .store(in: cancelBag)
        
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_애플인증처리_에러가발생시_에러반환() {
        
        let message = "애플 로그인 시도 중 생긴 oauth 오류입니다"
        let networkError = HMHNetworkError.oautheticationError(.appleLoginError)
        
        let appleService = MockOAuthAppleService()
        appleService.authorizeResult = Fail(error: networkError)
            .eraseToAnyPublisher()
        let mockFactory = MockOAuthServiceFactory()
        mockFactory.service = appleService
        
        sut = AuthRepository(authService: mockAuthService, oauthServiceFactory: mockFactory)
        
        // When
        let expectedError = AuthError.appleAuthrizeError
        let expectation = XCTestExpectation(description: message)
        
        sut.authorize(.apple)
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
