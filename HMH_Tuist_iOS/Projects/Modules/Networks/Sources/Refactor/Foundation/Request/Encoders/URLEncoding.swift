//
//  URLEncoding.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

public struct URLEncoding: ParameterEncodable {
    func encode(_ request: URLRequest, with parameters: Parameters?) -> AnyPublisher<URLRequest, HMHNetworkError.ParameterEncoding> {
        var request = request
        
        return checkValidURLData(parameters, request.url)
            .map { parameters, url -> URLRequest in
                if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                    urlComponents.queryItems = parameters.compactMap { key, value in
                        URLQueryItem(name: key, value: "\(value)")
                    }
                    request.url = urlComponents.url
                }
                return request
            }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
