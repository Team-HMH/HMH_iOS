//
//  JSONEncodingTest.swift
//  NetworksTests
//
//  Created by 류희재 on 11/11/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import XCTest
import Combine

import Core
import Networks


class JSONEncodingTest: XCTestCase {
    
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
}

// 정상적으로 인코딩 되는 경우
extension JSONEncodingTest {
    
}

extension JSONEncodingTest {
    func test_파라미터가Nil일때_invalidJSON_에러반환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = EncodableParameterMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "Nil parameters should fail")
        
        sut.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .invalidJSON)
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
        let requestParameter = EncodableParameterMockData.validEncodableParameter
        
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
    
    func test_파라미터와URL둘다Nil일때_invalidJSON_에러반환() {
        let requestData = URLRequestMockData.nilURLRequest
        let requestParameter = EncodableParameterMockData.nilParameters
        
        let expectation = XCTestExpectation(description: "Nil parameters should fail")
        
        sut.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .invalidJSON)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: cancelBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_파라미터가비어있을경우_정상적인변환() {
        let requestData = URLRequestMockData.validRequestData
        let requestParameter = EncodableParameterMockData.emptyParameters
        
        let expectation = XCTestExpectation(description: "유효한 파라미터와 URL입니다")
        
        // 3. encode 메서드 실행
        sut.encode(requestData, with: requestParameter)
            .sink(receiveCompletion: { completion in
                // 실패했을 경우 오류 메시지 출력
                if case .failure(let error) = completion {
                    XCTFail("Expected success, but got error: \(error)")
                }
            }, receiveValue: { urlRequest in
                // 4. 인코딩된 URLRequest의 HTTPBody가 적절하게 인코딩되었는지 확인
                if let bodyData = urlRequest.httpBody,
                   let decoded = try? JSONDecoder().decode(SimpleData.self, from: bodyData) {
                    XCTAssertEqual(decoded.name, nil, "\(decoded)") // "John"이 반환되는지 확인
                } else {
                    XCTFail("HTTPBody를 디코드할 수 없습니다.")
                }
                
                // 5. URL이 제대로 설정되었는지 확인
                XCTAssertEqual(urlRequest.url?.absoluteString, "https://example.com") // URL이 맞는지 확인
                
                // 6. 테스트 완료 시점 알림
                expectation.fulfill()
            })
            .store(in: cancelBag)
        
        // 7. 비동기 테스트 대기
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_JSON인코딩실패시_jsonEncodingFailed반환() {
        let requestData = URLRequestMockData.validRequestData
        
        let expectation = XCTestExpectation(description: "JSON 인코딩에 실패했습니다!")
        
        for requestParameter in EncodableParameterMockData.invalidParameterList {
            sut.encode(requestData, with: requestParameter)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTAssertEqual(error, .jsonEncodingFailed, "\(requestParameter)")
                        expectation.fulfill()
                    }
                }, receiveValue: { _ in
                    XCTFail("Expected failure, but got success \(requestParameter)")
                })
                .store(in: cancelBag)
            
            wait(for: [expectation], timeout: 1.0)
        }
    }
}
