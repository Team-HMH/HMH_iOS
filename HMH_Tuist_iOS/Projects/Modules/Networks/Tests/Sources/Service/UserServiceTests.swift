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
    var cancelBag: CancelBag!
    
    override func setUp() {
        cancelBag = CancelBag()
        sut = UserService()
        
        UserManager.shared.accessToken = "eeyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI1NSIsImlhdCI6MTczMDk2MTY2MiwiZXhwIjoxNzMxMTM0NDYyfQ.IUslL_OzE-NshP1cPeyLQpU2w3fsQAQhfhQIJzlmjdkw4EipmDhdHCXtY8F8IyTi2fig8IoMyY0n4XwWvioLtw"
        UserManager.shared.refreshToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI1NSIsImlhdCI6MTczMDk2MTY2MiwiZXhwIjoxNzMyMTcxMjYyfQ.QwsXx96ig2BMpXsobji-ZkseXO4aHrzXLxKmKeNMVABjpb6rfaLQDJ1Rh4ZgKWff003d3XJqN9582ZbsxJPjeA"
    }
    
    override func tearDown() {
        cancelBag = nil
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
