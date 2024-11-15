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

// 테스트해야되는것
// 적절한 값이 들어온 경우에서는  -> 정확히 URLRequest를 반환하고 있는지?
// 에러가 생긴다면 -> 잘 에러를 변환하고 있는지? (JSONEncoding, URLEncoding Test에서 명확한 에러가 나오는 상황은 테스트를 하기 떼문에 여기서는 RequestError 잘 변환하는지만 확인하면 좋을거 같음)

class TaskTest: XCTestCase {
    
    var cancelBag: CancelBag!
    let baseURL = URL(string: "https://example.com")!
    let method: HTTPMethod = .get
    let headers = ["Authorization": "Bearer token"]
    
    var mockURLEncoding: MockURLEncoding!
    var mockJSONEncoding: MockJSONEncoding!
    
    override func setUpWithError() throws {
        mockURLEncoding = MockURLEncoding()
        mockJSONEncoding = MockJSONEncoding()
        cancelBag = CancelBag()
        
    }
    
    override func tearDown() {
        mockURLEncoding = nil
        mockJSONEncoding = nil
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
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error, expectationError, "Expected success, but got error: \(error)")
                    expectation.fulfill()
                case .finished:
                    if expectationError != nil {
                        XCTFail("Expected error \(String(describing: expectationError)), but received success.")
                    }
                    expectation.fulfill()
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
                XCTAssertEqual(validRequest.httpMethod, self.method.rawValue)
                XCTAssertEqual(validRequest.allHTTPHeaderFields, self.headers)
                
                RequestTestHandler.checkValidQuaryItem(
                    expectation: expectation,
                    validRequest: validRequest,
                    expectedQueryItems: parameter.expectedQueryItems
                )
                
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1.0 * Double(requestParameter.count))
        }
    }
    
    //TODO: 핸들러 붙이고 테스트코드 수정
    func test_requestParameters_파라미터인코딩에러시_에러반환() {
        let requestParameter = ParameterValidatorMockData.validParameter
        let expectationURLErrorList: [HMHNetworkError.ParameterEncodingError] = [
            .emptyParameters,
            .urlEncodingFailed
        ]
        
        for expectationError in expectationURLErrorList {
            mockURLEncoding.urlEncodeResult = Fail(error: expectationError).eraseToAnyPublisher()
            let task = Task.requestParameters(requestParameter, urlencoder: mockURLEncoding)
            
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
                XCTAssertEqual(validRequest.url, self.baseURL)
                XCTAssertEqual(validRequest.httpMethod, self.method.rawValue)
                XCTAssertEqual(validRequest.allHTTPHeaderFields, self.headers)
                RequestTestHandler.checkValidHTTPBody(
                    expectation: expectation,
                    validRequest: validRequest,
                    expectedParameter: parameter
                )
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 1.0 * Double(requestEncodableParameter.count))
        }
    }
    
    //TODO: 핸들러 붙이고 테스트코드 수정
    func test_requestJSONEncodable_파라미터인코딩에러시_에러반환() {
        let requestParameter = ParameterValidatorMockData.validParameter
        let expectationJSONError = HMHNetworkError.ParameterEncodingError.jsonEncodingFailed
        
        mockURLEncoding.urlEncodeResult = Fail(error: expectationJSONError).eraseToAnyPublisher()
        let task = Task.requestParameters(requestParameter, urlencoder: mockURLEncoding)
        
        let expectation = XCTestExpectation(description: "파라미터 인코딩 시 에러가 생겨 실패했습니다!")
        let expectationError = expectationJSONError
        
        validTaskBuildRequest(
            task: task,
            expectation: expectation,
            expectationError: .parameterEncodingFailed(expectationError)
        )
        
        wait(for: [expectation], timeout: 1.0)
        
    }
}
