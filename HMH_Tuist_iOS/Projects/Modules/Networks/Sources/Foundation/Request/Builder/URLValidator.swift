//
//  URLValidaterHandler.swift
//  Networks
//
//  Created by 류희재 on 11/12/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Network

public struct URLValidator {
    
    public static func validateURL(_ urlString: String) -> Result<URL, HMHNetworkError.URLValidationError> {
        if urlString.isEmpty {
            return .failure(.emptyurlString)
        } else {
            // 1. URL 문자열의 앞뒤 공백 제거
            guard let url = URL(string: urlString.trimmingCharacters(in: .whitespaces)) else {
                return .failure(.invalidPath) // 잘못된 URL
            }
            
            // 2. 프로토콜 검증 (http 또는 https만 허용)
            guard let scheme = url.scheme, scheme == "http" || scheme == "https" else {
                return .failure(.invalidProtocol) // 잘못된 프로토콜
            }
            
            // 3. 포트 번호 검증 (0~65535 범위 내여야 함)
            if let port = url.port, port < 0 || port > 65535 {
                return .failure(.invalidPort) // 잘못된 포트 번호
            }
            
            // 4. 경로 검증
            if url.path.contains(" ") ||  url.path.contains("//") {
                return .failure(.invalidPath) // 경로에 공백 포함
            }
            
            // 5. URL 경로의 기타 문자가 잘못된 경우 처리 (특수 문자 등)
            let invalidCharacters: [Character] = ["|", "<", ">", "{", "}", "\"", "#", "%"]
            
            if url.path.contains(where: { invalidCharacters.contains($0) }) {
                return .failure(.invalidCharacters) // 경로에 유효하지 않은 특수 문자 포함
            }
            
            if url.path == "/" {
                return .failure(.invalidSlash)
            }

            if let query = url.query {
                let parameters = query.split(separator: "&")
                
                for param in parameters {
                    // 쿼리 파라미터에 '='가 빠진 경우
                    if !param.contains("=") {
                        return .failure(.invalidQueryParameter)
                    }
                }

                // 쿼리 구분자 '&&'가 포함된 경우
                if query.contains("&&") {
                    return .failure(.invalidQueryParameter)
                }
            }

            return .success(url) // 유효한 URL
            
        }
    }
}

