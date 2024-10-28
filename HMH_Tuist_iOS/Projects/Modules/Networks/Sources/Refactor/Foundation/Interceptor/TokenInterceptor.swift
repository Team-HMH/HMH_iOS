//
//  TokenInterceptor.swift
//  Networks
//
//  Created by 류희재 on 10/28/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

struct TokenInterceptor {
    
    private var retryLimit = 2
    
    static let shared = TokenInterceptor()
    
    private let reissueService: ReissueAPIService
    
    private init() {
        self.reissueService = ReissueAPIService()
    }
    
    
  func adapt(
    _ request: URLRequest
  ) async throws -> URLRequest {
    return request
  }


  func retry(
    for session: URLSession
  ) async throws {
      
  }
}
