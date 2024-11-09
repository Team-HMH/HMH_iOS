//
//  AuthServiceTests.swift
//  NetworksTests
//
//  Created by 류희재 on 10/30/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Networks
import Core

final class AuthServiceTests: XCTestCase {
    
    var sut: AuthServiceType!
    var cancelBag: CancelBag!
    
    override func setUp() {
        cancelBag = CancelBag()
        sut = AuthService()
        
        UserManager.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI1NSIsImlhdCI6MTczMDU1Mjk0OSwiZXhwIjoxNzMwNzI1NzQ5fQ.FdkQxEz_aNOGRt1dIIIf5FyrDQN9IdSJghBb-fXofPtpsno2X54V0PVCYHF2Kt7FgFXZirsKKOgpEoNqdt14Fw"
        UserManager.shared.refreshToken = "lNZIf_66imXVXmfWFwKz3QYRRUb-BdOUAAAAAgopyWAAAAGS7OcbNd0Jz_1t7hqp"
    }
    
    override func tearDown() {
        cancelBag = nil
        sut = nil
    }
    
    func test_회원가입_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.signUp(request: .stub)
        .sink { completion in
            if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
        } receiveValue: { roomDetails in
            expectation.fulfill()
        }
        .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_소셜로그인_서버통신이_정상적으로_진행되는가() {
        
        let expectation = XCTestExpectation()
        
        sut.socialLogin(request: SocialLoginRequest(socialPlatform: "KAKAO"))
            .sink { completion in
                if case let .failure(err) = completion { XCTFail(err.localizedDescription)}
            } receiveValue: { roomDetails in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
}
