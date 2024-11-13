//
//  TaskTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/12/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Core
import Networks

class TaskTest: XCTestCase {
    
    var cancelBag: CancelBag!
    let baseURL = URL(string: "https://example.com")!
    let method: HTTPMethod = .get
    let headers = ["Authorization": "Bearer token"]
    
    override func setUpWithError() throws {
        cancelBag = CancelBag()
        
    }
    
    override func tearDown() {
        cancelBag = nil
    }
    
    func validTaskBuildRequest(
        task: Task,
        expectation: XCTestExpectation,
        expectationError: HMHNetworkError.RequestError? = nil,
        validationBlock: @escaping ((URLRequest) -> Void) = { _  in }
    ) {
        task.buildRequest(baseURL: self.baseURL, method: self.method, headers: self.headers)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, expectationError)
                    expectation.fulfill()
                } else {
                    if case .failure(let error) = completion {
                        XCTFail("Expected success, but got error: \(error)")
                        expectation.fulfill()
                    }
                }
            }, receiveValue: validationBlock)
            .store(in: self.cancelBag)
    }
}

extension TaskTest {
    func test_requestPlain일때_body없이정상적인반환() {
        let task = Task.requestPlain
        let expectation = XCTestExpectation(description: "requestPlain일때 유효한 urlRequest를 반환합니다!")
        
        validTaskBuildRequest(task: task, expectation: expectation) { validRequest in
            XCTAssertEqual(validRequest.url, self.baseURL)
            XCTAssertEqual(validRequest.httpMethod, self.method.rawValue)
            XCTAssertEqual(validRequest.allHTTPHeaderFields, self.headers)
            XCTAssertNil(validRequest.httpBody, "Request body should be nil for plain request")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_requestParameters_정상적인파라미터일때_body없이정상적인반환() {
        let requestParameter = ParameterValidatorMockData.validParameters
        
        for parameter in requestParameter {
            let task = Task.requestParameters(parameter.parameters)
            let expectation = XCTestExpectation(description: "requestParameter일때 \(parameter)에 대한 유효한 urlRequest를 반환합니다!")
            
            validTaskBuildRequest(task: task, expectation: expectation) { validRequest in
                guard let url = validRequest.url,
                      let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                      let queryItems = components.queryItems else {
                    XCTFail("Invalid URL or missing query parameters")
                    return
                }
                
                let sortedQueryItems = queryItems.sorted(by: { $0.name < $1.name })
                let sortedExpectedQueryItems = parameter.expectedQueryItems.sorted(by: { $0.name < $1.name })
                
                XCTAssertEqual(sortedQueryItems, sortedExpectedQueryItems)
                XCTAssertEqual(validRequest.httpMethod, self.method.rawValue)
                XCTAssertEqual(validRequest.allHTTPHeaderFields, self.headers)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1.0 * Double(requestParameter.count))
        }
    }
    
    func test_requestParameters_파라미터인코딩에러시_에러반환() {
        let requestParameter = ParameterValidatorMockData.validParameter
        let expectationURLErrorList: [HMHNetworkError.ParameterEncodingError] = [
            .emptyParameters,
            .invalidParametersType,
            .missingURL
        ]
        
        for expectationError in expectationURLErrorList {
            let mockEncoder = MockParameterEncoding(error: expectationError)
            let task = Task.requestParameters(requestParameter, encoder: mockEncoder)
            
            let expectation = XCTestExpectation(description: "파라미터 인코딩 시 에러가 생겨 실패했습니다!")
            let expectationError = expectationError
            
            validTaskBuildRequest(
                task: task,
                expectation: expectation,
                expectationError: .parameterEncodingFailed(expectationError)
            )
            
            wait(for: [expectation], timeout: 1.0 * Double(requestParameter.count))
        }
    }
    
    func test_requestJSONEncodable_정상적인파라미터일때_httpbody를포함한_정상적인반환() {
        let requestEncodableParameter = EncodableParameterMockData.validParameters
        
        for parameter in requestEncodableParameter {
            let task = Task.requestJSONEncodable(parameter)
            let expectation = XCTestExpectation(description: "requestJSONEncodable일때 \(parameter)에 대한 유효한 urlRequest를 반환합니다!")
            
            validTaskBuildRequest(task: task, expectation: expectation) { validRequest in
                do {
                    let validJSON = try JSONSerialization.jsonObject(with: validRequest.httpBody!, options: []) as? [String: Any]
                    
                    let expectedData = try JSONEncoder().encode(parameter)
                    let expectedJSON = try JSONSerialization.jsonObject(with: expectedData, options: []) as? [String: Any]
                    
                    XCTAssertEqual(validJSON as NSDictionary?, expectedJSON as NSDictionary?, "파라미터가 예상 결과와 일치하지 않습니다.")
                    XCTAssertEqual(validRequest.url, self.baseURL)
                    XCTAssertEqual(validRequest.httpMethod, self.method.rawValue)
                    XCTAssertEqual(validRequest.allHTTPHeaderFields, self.headers)
                    expectation.fulfill()
                } catch {
                    XCTFail("JSON 처리 중 오류 발생: \(error)")
                    expectation.fulfill()
                }
            }
            wait(for: [expectation], timeout: 1.0 * Double(requestEncodableParameter.count))
        }
    }
    
    func test_requestJSONEncodable_파라미터인코딩에러시_에러반환() {
        let requestParameter = ParameterValidatorMockData.validParameter
        let expectationJSONErrorList: [HMHNetworkError.ParameterEncodingError] = [
            .invalidJSON,
            .jsonEncodingFailed,
            .missingURL
        ]
        
        for expectationError in expectationJSONErrorList {
            let mockEncoder = MockParameterEncoding(error: expectationError)
            let task = Task.requestParameters(requestParameter, encoder: mockEncoder)
            
            let expectation = XCTestExpectation(description: "파라미터 인코딩 시 에러가 생겨 실패했습니다!")
            let expectationError = expectationError
            
            validTaskBuildRequest(
                task: task,
                expectation: expectation,
                expectationError: .parameterEncodingFailed(expectationError)
            )
            
            wait(for: [expectation], timeout: 1.0 * Double(requestParameter.count))
        }
    }
}
