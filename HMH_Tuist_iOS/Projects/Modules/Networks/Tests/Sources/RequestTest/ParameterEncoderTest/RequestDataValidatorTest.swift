////
////  RequestValidatorTest.swift
////  NetworksTests
////
////  Created by 류희재 on 11/10/24.
////  Copyright © 2024 HMH-iOS. All rights reserved.
////
//
//import XCTest
//import Combine
//
//import Core
//import Networks
//
//
//class RequestDataValidatorTests: XCTestCase {
//    
//    var cancelBag: CancelBag!
//    var mockURL = URL(string: "https://example.com")!
//    
//    override func setUpWithError() throws {
//        cancelBag = CancelBag()
//    }
//    
//    override func tearDown() {
//        cancelBag = nil
//    }
//    
//    public func validateWithParameters(
//        parameters: Parameters?,
//        url: URL?,
//        expectedError: HMHNetworkError.ParameterEncodingError? = nil,
//        expectation: XCTestExpectation,
//        validationBlock: @escaping ((Parameters, URL) -> Void) = {_, _ in}) {
//            
//            RequestDataValidator.validateWithParameters(parameters, url)
//                .sink(receiveCompletion: { completion in
//                    if case .failure(let error) = completion {
//                        XCTAssertEqual(error, expectedError)
//                        expectation.fulfill()
//                    } else {
//                        if case .failure(let error) = completion {
//                            XCTFail("Expected success, but got error: \(error)")
//                        }
//                    }
//                }, receiveValue: validationBlock)
//                .store(in: cancelBag)
//        }
//    
//    public func validateWithEncodableParameters(
//        parameters: Encodable?,
//        url: URL?,
//        expectationError: HMHNetworkError.ParameterEncodingError? = nil,
//        expectation: XCTestExpectation,
//        validationBlock: @escaping ((Encodable, URL) -> Void) = {_, _ in}) {
//            
//            RequestDataValidator.validateWithEncodable(parameters, url)
//                .sink(receiveCompletion: { completion in
//                    if case .failure(let error) = completion {
//                        XCTAssertEqual(error, expectationError)
//                        expectation.fulfill()
//                    } else {
//                        if case .failure(let error) = completion {
//                            XCTFail("Expected success, but got error: \(error)")
//                        }
//                    }
//                }, receiveValue: validationBlock)
//                .store(in: cancelBag)
//        }
//}
//
//
//extension RequestDataValidatorTests {
//    func test_validateWithParameters_정상적인파라미터와URL일때_정상적인변환() {
//        let requestParameter = ParameterValidatorMockData.validParameters
//        let expectation = XCTestExpectation(description: "유효한 파라미터와 URL입니다!")
//        let expectationError: HMHNetworkError.ParameterEncodingError = .emptyParameters
//        
//        for parameter in requestParameter {
//            validateWithParameters(
//                parameters: parameter.parameters,
//                url: mockURL,
//                expectedError: expectationError,
//                expectation: expectation
//            ) { validParameters, validURL in
//                for (key, expectedValue) in parameter.parameters {
//                    XCTAssertEqual(validParameters[key] as? String, expectedValue as? String, "키: \(key) 값이 일치하지 않습니다.")
//                }
//                XCTAssertEqual(validURL, self.mockURL)
//                expectation.fulfill()
//            }
//        }
//        
//        wait(for: [expectation], timeout: 1.0 * Double(requestParameter.count))
//    }
//    
//    func test_validateWithParameters_파라미터가Nil일때_emptyParameters_에러반환() {
//        let requestParameter = ParameterValidatorMockData.nilParameters
//        let expectation = XCTestExpectation(description: "파라미터가 Nil이어서 실패했습니다!")
//        let expectationError: HMHNetworkError.ParameterEncodingError = .emptyParameters
//        
//        validateWithParameters(
//            parameters: requestParameter,
//            url: mockURL,
//            expectedError: expectationError,
//            expectation: expectation
//        )
//    }
//    
//    func test_validateWithParameters_URL이Nil일때_missingURL_에러반환() {
//        let requestParameter = ParameterValidatorMockData.validParameter
//        let expectation = XCTestExpectation(description: "URL이 Nil이어서 실패했습니다!")
//        let expectationError: HMHNetworkError.ParameterEncodingError = .missingURL
//        
//        validateWithParameters(
//            parameters: requestParameter,
//            url: nil,
//            expectedError: expectationError,
//            expectation: expectation
//        )
//        
//        wait(for: [expectation], timeout: 1.0)
//        
//    }
//    
//    func test_validateWithParameters_파라미터와URL둘다Nil일때_missingURL_에러반환() {
//        let requestParameter = ParameterValidatorMockData.nilParameters
//        let expectation = XCTestExpectation(description: "URL과 파라미터가 둘다 Nil이어서 (url 먼저 처리) 실패했습니다!")
//        let expectationError: HMHNetworkError.ParameterEncodingError = .missingURL
//        
//        validateWithParameters(
//            parameters: requestParameter,
//            url: nil,
//            expectedError: expectationError,
//            expectation: expectation
//        )
//        
//        wait(for: [expectation], timeout: 1.0)
//    }
//    
//    func test_validateWithParameters_파라미터가비어있을경우_emptyParameters_에러반환() {
//        let requestParameter = ParameterValidatorMockData.emptyParameters
//        let expectation = XCTestExpectation(description: "파라미터가 비어있어서 실패했습니다!")
//        let expectationError: HMHNetworkError.ParameterEncodingError = .emptyParameters
//        
//        validateWithParameters(
//            parameters: requestParameter,
//            url: mockURL,
//            expectedError: expectationError,
//            expectation: expectation
//        )
//        
//        wait(for: [expectation], timeout: 1.0)
//    }
//}
//
//extension RequestDataValidatorTests {
//    func test_validateWithEncodable_정상적인파라미터와URL일때_정상적인변환() {
//        let requestParameter = EncodableParameterMockData.validParameters
//        let expectation = XCTestExpectation(description: "유효한 파라미터와 URL입니다!")
//        let expectationError: HMHNetworkError.ParameterEncodingError = .emptyParameters
//        
//        for parameter in requestParameter {
//            validateWithEncodableParameters(
//                parameters: parameter,
//                url: mockURL,
//                expectationError: expectationError,
//                expectation: expectation
//            ) { validParameters, validURL in
//                do {
//                    let parameterData = try JSONEncoder().encode(parameter)
//                    let validParametersData = try JSONEncoder().encode(validParameters)
//                    XCTAssertEqual(parameterData, validParametersData, "파라미터가 예상 결과와 일치하지 않습니다.")
//                } catch {
//                    XCTFail("파라미터를 JSON으로 인코딩하지 못했습니다: \(error)")
//                }
//                XCTAssertEqual(validURL, self.mockURL)
//                expectation.fulfill()
//            }
//        }
//        
//        wait(for: [expectation], timeout: 1.0 * Double(requestParameter.count))
//    }
//    
//    func test_validateWithEncodable_파라미터가Nil일때_emptyParameters_에러반환() {
//        let requestParameter = EncodableParameterMockData.nilParameters
//        let expectation = XCTestExpectation(description: "파라미터가 Nil이어서 실패했습니다!")
//        let expectationError: HMHNetworkError.ParameterEncodingError = .emptyParameters
//        
//        validateWithEncodableParameters(
//            parameters: requestParameter,
//            url: mockURL,
//            expectationError: expectationError,
//            expectation: expectation
//        )
//        
//        wait(for: [expectation], timeout: 1.0)
//    }
//    
//    func test_validateWithEncodable_URL이Nil일때_missingURL_에러반환() {
//        let requestParameter = EncodableParameterMockData.validEncodableParameter
//        let expectation = XCTestExpectation(description: "URL이 Nil이어서 실패했습니다!")
//        let expectationError: HMHNetworkError.ParameterEncodingError = .missingURL
//        
//        validateWithEncodableParameters(
//            parameters: requestParameter,
//            url: nil,
//            expectationError: expectationError,
//            expectation: expectation
//        )
//        
//        wait(for: [expectation], timeout: 1.0)
//    }
//    
//    func test_validateWithEncodable_파라미터와URL둘다Nil일때_missingURL_에러반환() {
//        let requestParameter = EncodableParameterMockData.nilParameters
//        let expectation = XCTestExpectation(description: "URL과 파라미터가 둘다 Nil이어서 (url 먼저 처리) 실패했습니다!")
//        let expectationError: HMHNetworkError.ParameterEncodingError = .missingURL
//        
//        validateWithEncodableParameters(
//            parameters: requestParameter,
//            url: nil,
//            expectationError: expectationError,
//            expectation: expectation
//        )
//        
//        wait(for: [expectation], timeout: 1.0)
//    }
//}
//
