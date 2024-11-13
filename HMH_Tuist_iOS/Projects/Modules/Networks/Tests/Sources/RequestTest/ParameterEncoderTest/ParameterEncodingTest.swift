//
//  ParameterEncodingTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Core
import Networks


class ParameterEncodingTest: XCTestCase {
    var cancelBag: CancelBag!
    var sut: ParameterEncoding!
    
    override func setUpWithError() throws {
        sut = JSONEncoding()
        cancelBag = CancelBag()
        
    }
    
    override func tearDown() {
        sut = nil
        cancelBag = nil
    }
    
    func validateEncoding(
        encoder: ParameterEncoding,
        requestData: URLRequest,
        requestParameter: Any?,
        expectation: XCTestExpectation,
        expectationError: HMHNetworkError.ParameterEncodingError? = nil,
        validationBlock: @escaping ((URLRequest) -> Void) = { _  in})
    {
        encoder.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, expectationError)
                    expectation.fulfill()
                } else {
                    if case .failure(let error) = completion {
                        XCTFail("Expected success, but got error: \(error)")
                    }
                }
            }, receiveValue: validationBlock)
            .store(in: self.cancelBag)
    }
}
