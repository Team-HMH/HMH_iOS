//
//  NetworkResult.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/11/24.
//

import Foundation

import Moya
import Alamofire

enum NetworkResult<T> {
    case success(T)                    // 서버 통신 성공했을 때,
    case requestErr(T)                 // 요청 에러 발생했을 때,
    case decodedErr                    // 디코딩 오류 발생했을 때,
    case pathErr                       // 경로 에러 발생했을 때,
    case authorizationFail(T)          // 토큰 인증 오류,
    case serverErr                     // 서버의 내부적 에러가 발생했을 때,
    case networkFail                   // 네트워크 연결 실패했을 때
}

enum NetworkError: Error {
  case empty
  case timeout(Error)
  case internetConnection(Error)
  case restError(errorCode: String?, errorMessage: String?)
}

extension NetworkError {
  /// `Error` 타입을 `URLError`로 바꿉니다.
  static func convertToURLError(_ error: Error) -> URLError? {
    switch error {
    case let MoyaError.underlying(afError as AFError, _):
      fallthrough
    case let afError as AFError:
      return afError.underlyingError as? URLError
    case let MoyaError.underlying(urlError as URLError, _):
      fallthrough
    case let urlError as URLError:
      return urlError
    default:
      return nil
    }
  }
  
  /// 인터넷에 연결되어 있는지를 판별합니다.
  static func isNotConnection(error: Error) -> Bool {
    Self.convertToURLError(error)?.code == .notConnectedToInternet
  }
  
  /// 중간에 인터넷 연결이 끊어졌는지를 판별합니다.
  static func isLostConnection(error: Error) -> Bool {
    switch error {
    case let AFError.sessionTaskFailed(error: posixError as POSIXError)
      where posixError.code == .ECONNABORTED: // eConnAboarted: Software caused connection abort.
      break
    case let MoyaError.underlying(urlError as URLError, _):
      fallthrough
    case let urlError as URLError:
      guard urlError.code == URLError.networkConnectionLost else { fallthrough } // A client or server connection was severed in the middle of an in-progress load.
      break
    default:
      return false
    }
    return true
  }
}
