//
//  PointServiceTests.swift
//  NetworksTests
//
//  Created by 류희재 on 10/30/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Networks
import Core

final class PointServiceTests: XCTestCase {
    
    var sut: PointServiceType!
    var cancelBag: CancelBag!
    
    override func setUp() {
        cancelBag = CancelBag()
        sut = PointService()
        
        UserManager.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI1NSIsImlhdCI6MTczMDk2MTY2MiwiZXhwIjoxNzMxMTM0NDYyfQ.IUslL_OzE-NshP1cPeyLQpU2w3fsQAQhfhQIJzlmjdkw4EipmDhdHCXtY8F8IyTi2fig8IoMyY0n4XwWvioLtw"
        UserManager.shared.refreshToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI1NSIsImlhdCI6MTczMDk2MTY2MiwiZXhwIjoxNzMyMTcxMjYyfQ.QwsXx96ig2BMpXsobji-ZkseXO4aHrzXLxKmKeNMVABjpb6rfaLQDJ1Rh4ZgKWff003d3XJqN9582ZbsxJPjeA"
    }
    
    override func tearDown() {
        cancelBag = nil
        sut = nil
    }
    
    func test_포인트사용_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.patchPointUse()
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation])
        
    }
    
    func test_받을포인트반환_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.getEarnPoint()
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation])
        
    }
    
    func test_사용할포인트반환_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.getUsagePoint()
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_포인트수령여부조회_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.getPointList()
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_포인트받기_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.patchEarnPoint(request: UserPointRequest(challengeDate: "2024-03-16"))
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
    }
}
