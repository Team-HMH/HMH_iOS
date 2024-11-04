//
//  UserServiceTests.swift
//  NetworksTests
//
//  Created by 류희재 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Networks
import Core

final class UserServiceTests: XCTestCase {

    var sut: UserServiceType!
    var mockRequestHandler: RequestHandling!
    var cancelBag: CancelBag!
    
    override func setUp() {
        cancelBag = CancelBag()
        mockRequestHandler = RequestHandler()
        sut = UserService(requestHandler: mockRequestHandler)
        
        UserManager.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzMwMjcyMDkyLCJleHAiOjE3MzA0NDQ4OTJ9.FULSF-b-cu4iH25ld_EgL99g310XT1uTHcyyebBgxxpYERXXk19Mb-TyfaeDEWUMpkC6vjrjWz5yPc27fPbPTQ"
        UserManager.shared.refreshToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzMwMjcyMDkyLCJleHAiOjE3MzE0ODE2OTJ9.9SrHLvCCbFVt_p6GZvh0P91CgLSZfH3VgFDH2HZHiVHXdjC0O_4OUiv9wZI4Hmf3BwSer8awR8ilOTsKIODS6A"
    }
    
    override func tearDown() {
        cancelBag = nil
        mockRequestHandler = nil
        sut = nil
    }
    
    func test_로그아웃_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.logout()
        .sink { completion in
            if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
        } receiveValue: { roomDetails in
            expectation.fulfill()
        }
        .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_회원탈퇴_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.deleteAccount()
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_유저정보불러오기_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.getUserData()
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_유저포인트정보불러오기_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.getCurrentPoint()
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
}
