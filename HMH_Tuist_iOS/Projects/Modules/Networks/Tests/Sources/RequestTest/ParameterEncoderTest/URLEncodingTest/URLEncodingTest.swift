//
//  URLEncodingTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/11/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Core
import Networks


class URLEncodingTest: XCTestCase {
    
    var cancelBag: CancelBag!
    var sut: ParameterEncoding!
    
    override func setUpWithError() throws {
        sut = URLEncoding()
        cancelBag = CancelBag()
        
    }
    
    override func tearDown() {
        sut = nil
        cancelBag = nil
    }
}

// 정상적으로 인코딩 되는 경우
extension URLEncodingTest {
    func test_정상적인파라미터와URL이_정상적으로인코딩되는지() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameters = ParameterValidatorMockData.validParameter
        
        let expectation = XCTestExpectation(description: "유효한 파라미터와 URL입니다")
        
        sut.encode(requestData, with: requestParameters)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but got error: \(error)")
                }
            }, receiveValue: { resultRequest in
                XCTAssertNotNil(resultRequest.url)
                if let url = resultRequest.url?.absoluteString {
                    XCTAssertTrue(url.contains("username=hellohidi"))
                    XCTAssertTrue(url.contains("age=25"))
                    XCTAssertEqual(resultRequest.url?.host, "example.com")
                } else {
                    XCTFail("Expected valid URL but found nil")
                }
                
                expectation.fulfill()
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_한글과이모지가포함된파라미터가_정상적으로인코딩되는지() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameters = ParameterValidatorMockData.unicodeCharacters
        
        let expectation = XCTestExpectation(description: "유효한 파라미터와 URL입니다")
        
        sut.encode(requestData, with: requestParameters)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but got error: \(error)")
                }
            }, receiveValue: { resultRequest in
                XCTAssertNotNil(resultRequest.url)
                
                if let url = resultRequest.url?.absoluteString {
                    XCTAssertTrue(url.contains("greeting=%EC%95%88%EB%85%95%ED%95%98%EC%84%B8%EC%9A%94"))
                    XCTAssertTrue(url.contains("emoji=%F0%9F%99%82%F0%9F%9A%80"), "\(url)")
                    XCTAssertEqual(resultRequest.url?.host, "example.com")
                } else {
                    XCTFail("Expected valid URL but found nil")
                }
                
                expectation.fulfill()
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_bool타입파라미터가_정상적으로인코딩되는지() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameters = ParameterValidatorMockData.booleanValues
        
        let expectation = XCTestExpectation(description: "유효한 파라미터와 URL입니다")
        
        sut.encode(requestData, with: requestParameters)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but got error: \(error)")
                }
            }, receiveValue: { resultRequest in
                XCTAssertNotNil(resultRequest.url)
                if let url = resultRequest.url?.absoluteString {
                    XCTAssertTrue(url.contains("isActive=true"))
                    XCTAssertTrue(url.contains("isAdmin=false"))
                    XCTAssertEqual(resultRequest.url?.host, "example.com")
                } else {
                    XCTFail("Expected valid URL but found nil")
                }
                
                expectation.fulfill()
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    //    func test_특수문자가포함된파라미터가_정상적으로인코딩되는지() {
    //        let requestData = URLEncodingMockData.validRequestData
    //        let requestParameters = ParameterValidatorMockData.specialCharacters
    //        
    //        let expectation = XCTestExpectation(description: "유효한 파라미터와 URL입니다")
    //        
    //        sut.encode(requestData, with: requestParameters)
    //            .sink(receiveCompletion: { completion in
    //                if case .failure(let error) = completion {
    //                    XCTFail("Expected success, but got error: \(error)")
    //                }
    //            }, receiveValue: { resultRequest in
    //                XCTAssertNotNil(resultRequest.url)
    //                
    //                if let url = resultRequest.url?.absoluteString {
    //                    XCTAssertTrue(url.contains("query=name%3Dhello%26value%3Dworld"))
    //                    XCTAssertTrue(url.contains("symbol=%21%40%23%24%255E%26%2A%28%29%5F%2B%7C"), "\(url)")
    //                    XCTAssertEqual(resultRequest.url?.host, "example.com")
    //                } else {
    //                    XCTFail("Expected valid URL but found nil")
    //                }
    //                
    //                expectation.fulfill()
    //            })
    //            .store(in: cancelBag)
    //        
    //        wait(for: [expectation], timeout: 1.0)
    //    }
    
    func test_큰수를포함된파라미터가_정상적으로인코딩되는지() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameters = ParameterValidatorMockData.largeNumbers
        
        let expectation = XCTestExpectation(description: "유효한 파라미터와 URL입니다")
        
        sut.encode(requestData, with: requestParameters)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but got error: \(error)")
                }
            }, receiveValue: { resultRequest in
                XCTAssertNotNil(resultRequest.url)
                
                if let url = resultRequest.url?.absoluteString {
                    XCTAssertTrue(url.contains("count=123456789"))
                    XCTAssertTrue(url.contains("maxValue=9223372036854775807"))
                    XCTAssertTrue(url.contains("minValue=-9223372036854775808"))
                    XCTAssertEqual(resultRequest.url?.host, "example.com")
                } else {
                    XCTFail("Expected valid URL but found nil")
                }
                
                expectation.fulfill()
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_벨류값이비어있을때_정상적으로인코딩되는지() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameters = ParameterValidatorMockData.emptyStrings
        
        let expectation = XCTestExpectation(description: "유효한 파라미터와 URL입니다")
        
        sut.encode(requestData, with: requestParameters)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but got error: \(error)")
                }
            }, receiveValue: { resultRequest in
                XCTAssertNotNil(resultRequest.url)
                if let url = resultRequest.url?.absoluteString {
                    XCTAssertTrue(url.contains("title="))
                    XCTAssertTrue(url.contains("description="))
                    XCTAssertEqual(resultRequest.url?.host, "example.com")
                } else {
                    XCTFail("Expected valid URL but found nil")
                }
                
                expectation.fulfill()
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}

extension URLEncodingTest {
    func test_파라미터가Nil일때_invalidParametersType_에러반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = ParameterValidatorMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "Nil parameters should fail")
        
        sut.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .invalidParametersType)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_URL이Nil일때_missingURL_에러반환() {
        let requestData = URLRequestMockData.nilURLRequest
        let requestParameter = ParameterValidatorMockData.validParameter
        
        let expectation = XCTestExpectation(description: "Nil parameters should fail")
        
        sut.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .missingURL)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_파라미터와URL둘다Nil일때_invalidParametersType_에러반환() {
        let requestData = URLRequestMockData.nilURLRequest
        let requestParameter = ParameterValidatorMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "Nil parameters should fail")
        
        sut.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .invalidParametersType)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_파라미터가비어있을경우_emptyParameters_에러반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = ParameterValidatorMockData.emptyParameters
        
        let expectation = XCTestExpectation(description: "Nil parameters should fail")
        
        sut.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .emptyParameters)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
