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
    var mockRequestHandler: RequestHandling!
    var cancelBag: CancelBag!
    
    override func setUp() {
        cancelBag = CancelBag()
        mockRequestHandler = RequestHandler()
        sut = ChallengeService(requestHandler: mockRequestHandler)
        
        UserManager.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzMwMjcyMDkyLCJleHAiOjE3MzA0NDQ4OTJ9.FULSF-b-cu4iH25ld_EgL99g310XT1uTHcyyebBgxxpYERXXk19Mb-TyfaeDEWUMpkC6vjrjWz5yPc27fPbPTQ"
        UserManager.shared.refreshToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzMwMjcyMDkyLCJleHAiOjE3MzE0ODE2OTJ9.9SrHLvCCbFVt_p6GZvh0P91CgLSZfH3VgFDH2HZHiVHXdjC0O_4OUiv9wZI4Hmf3BwSer8awR8ilOTsKIODS6A"
    }
    
    override func tearDown() {
        cancelBag = nil
        mockRequestHandler = nil
        sut = nil
    }
    
    func test_홈이용시간통계불러오기_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.getdailyChallenge()
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
