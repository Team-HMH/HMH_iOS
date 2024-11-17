//
//  NetworkLogHandler.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

struct NetworkLogHandler {
    
    // 네트워크 요청 로깅 함수
    static func requestLogging(_ endpoint: URLRequestTargetType) {
        let url = endpoint.url + (endpoint.path ?? "")
        let method = endpoint.method.rawValue
        let headers = endpoint.headers ?? [:]
        let parameters = endpoint.task
        
        print("""
            ================== 📤 Request ===================>
            📝 URL: \(url)
            📝 HTTP Method: \(method)
            📝 Header: \(headers)
            📝 Parameters: \(parameters)
            ================================
            """)
    }
    
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
    
    // 에러 응답 로깅 함수
    static func responseError(_ endpoint: any URLRequestTargetType, result error: HMHNetworkError) {
        let url = endpoint.url + (endpoint.path ?? "")
        let headers = endpoint.headers ?? [:]
        
        print("""
            ======================== 📥 Response <========================
            ========================= ❌ Error ==========================
            ❗️ Error Type: \(error.description)
            ❗️ URL: \(url)
            ❗️ Header: \(headers)
            ❗️ Error Data: \(error)
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



extension NetworkLogHandler {
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
        result error: HMHNetworkError.RequestError.ParameterEncodingError
    ) {
        let url = request.url?.absoluteString ?? "없음"
        let method = request.httpMethod ?? "없음"
        let headers = request.allHTTPHeaderFields ?? [:] // 빈 딕셔너리로 대체
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
