//
//  RequestValidatorTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/10/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Core
import Networks


class RequestDataValidatorTests: XCTestCase {
    
    var cancelBag: CancelBag!
    var mockURL = URL(string: "https://example.com")!
    
    override func setUpWithError() throws {
        cancelBag = CancelBag()
    }
    
    override func tearDown() {
        cancelBag = nil
    }
}
