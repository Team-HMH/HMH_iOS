//
//  ChallengeServiceTests.swift
//  NetworksTests
//
//  Created by 류희재 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Networks
import Core

final class ChallengeServiceTests: XCTestCase {
    
    var sut: ChallengeServiceType!
    var cancelBag: CancelBag!
    
    override func setUp() {
        cancelBag = CancelBag()
        sut = ChallengeService()
        
        UserManager.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI1NSIsImlhdCI6MTczMDk2MTY2MiwiZXhwIjoxNzMxMTM0NDYyfQ.IUslL_OzE-NshP1cPeyLQpU2w3fsQAQhfhQIJzlmjdkw4EipmDhdHCXtY8F8IyTi2fig8IoMyY0n4XwWvioLt"
        UserManager.shared.refreshToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI1NSIsImlhdCI6MTczMDk2MTY2MiwiZXhwIjoxNzMyMTcxMjYyfQ.QwsXx96ig2BMpXsobji-ZkseXO4aHrzXLxKmKeNMVABjpb6rfaLQDJ1Rh4ZgKWff003d3XJqN9582ZbsxJPjeA"
    }
    
    override func tearDown() {
        cancelBag = nil
        sut = nil
    }
    
    func test_홈이용시간통계불러오기_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.getDailyChallenge()
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_챌린지성공여부리스트전송_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.getSuccesChallenge()
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_챌린지생성_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.createChallenge(request: .stub)
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_당일잠금여부확인_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.getLockChallenge()
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_당일잠금여부전송_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.postLockChallenge()
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_스크린타임설정한앱삭제_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.deleteApp(request: .stub)
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_달성현황정보불러오기_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.getChallenge()
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_스크린타임설정할앱추가_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.addApp(request: .stub)
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
}
