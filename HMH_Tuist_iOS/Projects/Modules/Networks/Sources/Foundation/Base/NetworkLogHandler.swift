//
//  NetworkLogHandler.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

struct NetworkLogHandler {
    // 디코딩 로깅 함수
    static func responseDecodingError<T: Decodable>(
        data: Data,
        decodingType: T.Type,
        error: HMHNetworkError.DecodeError
    ) {
        let jsonString = String(data: data, encoding: .utf8) ?? "Invalid Data"
        
        print("""
            ======================== 📥 Response <========================
            ========================= ❌ Decoding Error ==========================
            ❗️ Error Type: \(error.description)
            ❗️ Expected Decoding Type: \(decodingType)
            ❗️ Error Data: \(jsonString)
            ==============================================================
            """)
    }
    
    static func tokenIntercepterRetryLogging(retryCnt: Int) {
        print("""
            ======================== 🪄 retry <========================
            🪄 토큰이 만료되어서 retry 작업을 실행합니다
            🪄 실행 횟수 \(retryCnt) -> \(3-retryCnt)이후 🚨요청횟수 초과🚨 에러가 발생합니다!
            ==============================================================
            """)
        
    }
    
    static func tokenIntercepterRetryError(error: HMHNetworkError) {
        print("""
            ========================= ❌ Retry Error ==========================
            ❗️ Error Type: \(error.description)
            ==============================================================
            """)
        
    }
}

// 네트워크 응답 로깅 함수
extension NetworkLogHandler {
    static func responseLogging(
        _ endpoint: URLRequestTargetType,
        result response: NetworkResponse
    ) {
        print("""
            ======================== 📥 Response <========================
            [EndPoint Information]
            1️⃣ URL: \(endpoint.url)
            2️⃣ Path: \(endpoint.path ?? "없음")
            3️⃣ Method: \(endpoint.method)
            4️⃣ headers: \(endpoint.headers ?? [:])
            5️⃣ task: \(endpoint.task)
            ========================= ✌🏻 응답이 도착했습니다 =========================
            ✌🏻 StatusCode: \(response.response.statusCode)
            ✌🏻 responseData: \(String(data: response.data ?? Data(), encoding: .utf8) ?? "No data")
            ==============================================================
            """
        )
    }
    
    static func NoResponseError(
        _ endpoint: URLRequestTargetType,
        error: HMHNetworkError.ResponseError
    ) {
        print("""
            ======================== 📤 네트워크 응답시 발생한 에러입니다 📤========================
            ========================= ❌ NoResponse Error ❌ ==========================
            ❗️ Error Type: \(error.description)
            """)
    }
    
    static func invalidReponseError(
        response: NetworkResponse,
        error: HMHNetworkError.ResponseError
    ) {
        print("""
            ======================== 📤 네트워크 응답시 발생한 에러입니다 📤========================
            ========================= ❌ invalidResponse Error ❌ ==========================
            ❗️ Error Type: \(error.description)
            ❗️ responseData: \(String(data: response.data ?? Data(), encoding: .utf8) ?? "No data")
            ❗️ StatusCode: \(response.response.statusCode)
            ==============================================================
            """
        )
    }
}


// 네트워크 요청 로깅 함수
extension NetworkLogHandler {
    static func requestLogging(_ request: URLRequest) {
        let requestURL = request.url?.absoluteString ?? "없음"
        let requestHTTPmethod = request.httpMethod ?? "없음"
        let requestHeaders = request.allHTTPHeaderFields ?? [:]
        var parameters: Any?
        
        if let httpBody = request.httpBody {
            if let jsonObject = try? JSONSerialization.jsonObject(with: httpBody, options: []),
               let encodableParameter = jsonObject as? [String: Any] {
                parameters = encodableParameter
            } else { return }
        }
        
        // HTTPBody가 없으면 URLQueryItem에서 추출
        if let url = request.url, let components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            var queryParameters: [String: Any] = [:]
            components.queryItems?.forEach { queryItem in
                if let value = queryItem.value {
                    queryParameters[queryItem.name] = value
                }
            }
            parameters = queryParameters
        }
        
        print("""
            ================== 📤 Request ===================>
            📝 URL: \(requestURL)
            📝 HTTP Method: \(requestHTTPmethod)
            📝 Header: \(requestHeaders)
            📝 Parameters: \(parameters ?? "없음")
            ================================
            """)
    }
    
    static func requestInvalidURLError(
        _ endpoint: any URLRequestTargetType,
        result error: HMHNetworkError.RequestError.URLValidationError
    ) {
        let url = endpoint.url + (endpoint.path ?? "")
        let method = endpoint.method
        let headers = endpoint.headers ?? [:]
        let task = endpoint.task
        
        print("""
            ======================== 📤 네트워크 요청 📤========================
            ========================= ❌ InvalidURL Error ❌ ==========================
            ❗️ Error Type: \(error.description)
            ❗️ 🚨 URL: \(url) 🚨
            ❗️ Method: \(method)
            ❗️ Header: \(headers)
            ❗️ Task: \(task)
            ==============================================================
            """)
    }
    
    static func requestParameterEncodingError(
        _ request: URLRequest,
        _ parameter: Any? = nil,
        error: HMHNetworkError.RequestError.ParameterEncodingError
    ) {
        let url = request.url?.absoluteString ?? "없음"
        let method = request.httpMethod ?? "없음"
        let headers = request.allHTTPHeaderFields ?? [:]
        let parameterDescription = parameter.map { String(describing: $0) } ?? "없음"
        
        print("""
            ======================== 📤 네트워크 요청 📤 ========================
            ========================= ❌ ParameterEncoding Error ❌ ==========================
            ❗️ Error Type: \(error.description)
            ❗️ URL: \(url)
            ❗️ Method: \(method)
            ❗️ Header: \(headers)
            ❗️ 🚨 Parameter: \(parameterDescription) 🚨
            ==============================================================
        """)
    }
}
