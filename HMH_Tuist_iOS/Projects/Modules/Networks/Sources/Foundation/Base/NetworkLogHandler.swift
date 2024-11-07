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
        let url = endpoint.url + (endpoint.path ?? "")
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
            ❗️ Error Data: \(error.localizedDescription)
            ==============================================================
            """)
    }
}

