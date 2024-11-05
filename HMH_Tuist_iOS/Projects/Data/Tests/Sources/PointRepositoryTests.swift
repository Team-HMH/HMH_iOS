//
//  PointRepositoryTests.swift
//  DataTests
//
//  Created by 류희재 on 11/4/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Networks
import Core
import Domain
import Data

final class PointRepositoryTests: XCTestCase {
    
    var sut: PointRepositoryType!
    var mockService: MockPointService!
    var cancelBag: CancelBag!
    
    override func setUpWithError() throws {
        cancelBag = CancelBag()
        mockService = MockPointService()
        sut = PointRepository(service: mockService)
    }
    
    override func tearDown() {
        cancelBag = nil
        mockService = nil
        sut = nil
    }
}

/// 포인트 사용 API  데이터 변환 테스트
extension PointRepositoryTests {
    func test_포인트사용_정상적인변환() {
        // Given
        let expectedUserPointInfo = UserPointInfo(usagePoint: 100, remainPoint: 100)
        mockService.patchPointUseResult = Just(UsePointResult.stub)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
        
        // When
        let expectation = XCTestExpectation(description: "포인트 사용 관련 레포지토리 변환이 정상적으로 성공했습니다!")
        sut.patchPointUse()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("포인트 사용 API 변환 중 실패했습니다: 에러 \(error)")
                }
            }, receiveValue: { userPointInfo in
                // Then
                XCTAssertEqual(userPointInfo, expectedUserPointInfo)
                expectation.fulfill()
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_포인트사용_포인트가음수일때_에러반환() {
        // Given
        let expectedUserPointInfo = UserPointInfo(usagePoint: -100, remainPoint: -100)
        
        let mockData = UsePointResult(usagePoint: -100, userPoint: -100)
        mockService.patchPointUseResult = Just(mockData)
            .setFailureType(to: HMHNetworkError.self)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "음수 값이 변환된 Entity로 전달되는지 확인합니다.")
        sut.patchPointUse()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("포인트 사용 API 변환 중 실패했습니다: 에러 \(error)")
                }
            }, receiveValue: { userPointInfo in
                // Then
                XCTAssertEqual(userPointInfo.usagePoint, expectedUserPointInfo.usagePoint)
                XCTAssertEqual(userPointInfo.remainPoint, expectedUserPointInfo.remainPoint)
                expectation.fulfill()
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_포인트사용_네트워크에러발생시_에러반환() {
        mockService.patchPointUseResult = Fail(error: HMHNetworkError.testErr) // 적절한 에러 케이스
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "에러 발생 시 에러 반환")
        
        sut.patchPointUse()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, PointError.unknown) // 예상한 에러와 비교
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_포인트사용_포인트부족시_에러반환() {
        let message = "포인트가 부족합니다." // 부족한 포인트에 대한 에러 메시지
        let networkError = HMHNetworkError.invalidResponse(.invalidStatusCode(code: 400, message: message))
        
        mockService.patchPointUseResult = Fail(error: networkError)
            .eraseToAnyPublisher()
        
        
        
        let expectedError = PointError.insufficientPoints
        let expectation = XCTestExpectation(description: "포인트가 부족합니다.")
        
        sut.patchPointUse()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, expectedError) // 예상한 에러와 비교
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}




