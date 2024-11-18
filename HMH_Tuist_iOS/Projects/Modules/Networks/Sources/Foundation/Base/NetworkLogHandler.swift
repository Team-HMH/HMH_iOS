//
//  NetworkLogHandler.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

struct NetworkLogHandler {
    // 성공적인 응답 로깅 함수
    static func responseSuccess(_ endpoint: any URLRequestTargetType, result response: NetworkResponse) {
        let url = endpoint.url + "/" + (endpoint.path ?? "")
        let headers = endpoint.headers ?? [:]
        let responseData = String(data: response.data ?? Data(), encoding: .utf8) ?? "No data"
        
        print("""
            ======================== 📥 Response <========================
            ========================= ✅ Success =========================
            ✌🏻 URL: \(url)
            ✌🏻 Header: \(headers)
            ✌🏻 Success Data: \(responseData)
            ==============================================================
            """)
    }
    
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
            ❗️ Error Type: \(error)
            ❗️ Expected Decoding Type: \(decodingType)
            ❗️ Error Data: \(jsonString)
            ==============================================================
            """)
    }
    
}

// 네트워크 응답 로깅 함수
extension NetworkLogHandler {
    
    static func NoResponseError(
        _ endpoint: URLRequestTargetType,
        error: HMHNetworkError.ResponseError
    ) {
        let url = endpoint.url + (endpoint.path ?? "")
        let method = endpoint.method
        let headers = endpoint.headers ?? [:]
        let task = endpoint.task
        
        print("""
            ✅ URL 유효성 체크
            ✅ Encode 체크
            ✅ 요청 성공
            ======================== 📤 네트워크 요청 📤========================
            ========================= ❌ NoResponseError ❌ ==========================
            ❗️ Error Type: \(error.description)
            ❗️ 🚨 URL: \(url) 🚨
            ❗️ Method: \(method)
            ❗️ Header: \(headers)
            ❗️ Task: \(task)
            ==============================================================
            """)
    }
    
    
    
    // 에러 응답 로깅 함수
    static func responseError(
        _ target: URLRequestTargetType,
        _ request: URLRequest,
        _ parameter: Any? = nil,
        error: HMHNetworkError.ResponseError
    ) {
        
        let url = target.url
        let method = target.method
        let headers = target.headers ?? [:]
        let task = target.task
        
        
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
            ======================== 📥 네트워크 응답 <========================
            ========================= ❌ Error ==========================
            ❗️ Error Type: \(error.description)
            
            1️⃣ URL
            - 요청: \(url)
            - 응답: \(requestURL)
            
            2️⃣ Method
            - 요청: \(method)
            - 응답: \(requestHTTPmethod)
            
            3️⃣ Headers
            - 요청: \(headers)
            - 응답: \(requestHeaders)
            
            4️⃣ Task
            - 요청: \(task)
            - 응답: \(parameters ?? "파라미터가 없습니다")
            
            ==============================================================
            """)
    }
}


// 네트워크 요청 로깅 함수
extension NetworkLogHandler {
    static func requestLogging(_ endpoint: URLRequestTargetType) {
        let url = endpoint.url + (endpoint.path ?? "")
        let method = endpoint.method.rawValue
        let headers = endpoint.headers ?? [:]
        let parameters = endpoint.task
        
        print("""
            ✅ URL 유효성 체크
            ✅ Encode 체크
            ================== 📤 Request ===================>
            📝 URL: \(url)
            📝 HTTP Method: \(method)
            📝 Header: \(headers)
            📝 Parameters: \(parameters)
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
            ✅ URL 유효성 체크
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
