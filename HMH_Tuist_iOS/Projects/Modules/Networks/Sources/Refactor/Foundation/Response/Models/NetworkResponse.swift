//
//  NetworkResponse.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct NetworkResponse {
    public let data: Data?
    public let response: HTTPURLResponse
    public let error: Error?
    
    public init(data: Data?, response: HTTPURLResponse, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
}
