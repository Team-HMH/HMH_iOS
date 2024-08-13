//
//  BaseAPI.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Alamofire
import Moya
import Foundation
import Core

public enum APIType {
  case auth
  case user
}

public protocol BaseAPI: TargetType {
  static var apiType: APIType { get set }
}

extension BaseAPI {
  public var baseURL: URL {
    var base = "Config.Network.baseURL"
    let operationBaseURL = "Config.Network.operationBaseURL"
    
    switch Self.apiType {
    case .auth:
      base += "/auth"
    case .user:
      base += "/user"
    }
    
    guard let url = URL(string: base) else {
      fatalError("baseURL could not be configured")
    }
    
    return url
  }
  
  public var headers: [String: String]? {
    return HeaderType.jsonWithToken.value
  }
  
  public var validationType: ValidationType {
    return .customCodes(Array(200..<600).filter { $0 != 401 })
  }
}

public enum HeaderType {
  case json
  case jsonWithToken
  case multipartWithToken
  
  public var value: [String: String] {
    switch self {
    case .json:
      return ["Content-Type": "application/json"]
    case .jsonWithToken:
      return ["Content-Type": "application/json",
              "Authorization": UserManager.shared.accessToken]
    case .multipartWithToken:
      return ["Content-Type": "multipart/form-data",
              "Authorization": UserManager.shared.accessToken]
    }
  }
}
