//
//  URLValidaterHandler.swift
//  Networks
//
//  Created by 류희재 on 11/12/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct URLValidator {
    public static func validateURL(_ urlString: String) -> Result<URL, HMHNetworkError.RequestError.URLValidationError> {
        if urlString.isEmpty {
            return .failure(.emptyurlString)
        }
        
        let trimmedURLString = urlString.trimmingCharacters(in: .whitespaces)
        
        guard let url = URL(string: trimmedURLString) else {
            return .failure(.invalidPath)
        }
        
        if !validateScheme(url) {
            return .failure(.invalidProtocol)
        }
        
        if !validatePort(url) {
            return .failure(.invalidPort)
        }
        
        if !validatePath(url, originalURLString: trimmedURLString) {
            return .failure(.invalidPath)
        }
        
        if let query = url.query, !validateQuery(query) {
            return .failure(.invalidQueryParameter)
        }
        
        return .success(url)
    }
    
    private static func validateScheme(_ url: URL) -> Bool {
        guard let scheme = url.scheme else { return false }
        return scheme == "http" || scheme == "https"
    }
    
    private static func validatePort(_ url: URL) -> Bool {
        guard let port = url.port else { return true }
        return (0...65535).contains(port)
    }
    
    private static func validatePath(_ url: URL, originalURLString: String) -> Bool {
        let invalidCharacters: Set<Character> = ["|", "<", ">", "{", "}", "\\", "#", "%"]
        let path = url.path

        // 기본 경로 유효성 검증
        let hasInvalidCharacters = path.contains(" ") ||
                                   path.contains("//") ||
                                   path.contains(where: invalidCharacters.contains)

        // URL 인코딩 검사: 원본 문자열과 비교하여 달라졌다면 유효하지 않은 URL로 간주
//        guard let encodedOriginal = originalURLString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
//              encodedOriginal == url.absoluteString else {
//            return false
//        }
        
        // 경로에서 #을 제외한 다른 특수 문자가 있으면 invalid 처리
            if let fragment = url.fragment, !fragment.isEmpty {
                return false  // fragment는 유효하므로 경로와 별도로 처리
            }

        return !hasInvalidCharacters
    }
    
    private static func validateQuery(_ query: String) -> Bool {
        let parameters = query.split(separator: "&")
        
        for param in parameters {
            if !param.contains("=") {
                return false
            }
        }
        return !query.contains("&&")
    }
}
