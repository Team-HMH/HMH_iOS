//
//  AuthInterceptor.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/12/24.
//
//

import Foundation

import Alamofire
import Moya

import Core
import Domain

///// 토큰 만료 시 자동으로 refresh를 위한 서버 통신
final class AuthInterceptor: RequestInterceptor {
    
    private var retryLimit = 2
    static let shared = AuthInterceptor()
    
    private init() {}
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("---adater 진입----")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("-------🔧retry 시작🔧-------")
        guard
            let statusCode = request.response?.statusCode,
            request.retryCount < retryLimit
        else {
            print("🚨재시도 횟수가 너무 많습니다🚨")
            return completion(.doNotRetry)
        }
        
        if let statusCode = request.response?.statusCode,
           request.retryCount < retryLimit {
            if statusCode == 401 {
                let provider = Providers.AuthProvider
                provider.request(target: .tokenRefresh, instance: BaseResponse<RefreshTokebResponseDTO>.self) { result in
                    if result.status == 200 {
                        if let data = result.data {
                            UserManager.shared.accessToken = data.token.accessToken
                            UserManager.shared.refreshToken = data.token.refreshToken
                        }
                        print("🪄토큰 재발급에 성공했습니다🪄")
                        completion(.retry)
                    } else if statusCode == 401 {
                        /// 리프레쉬 토큰도 만료된 상황
                        UserManager.shared.appStateString = "login"
                    }
                }
            }
        } else if statusCode == 404 {
            /// 유저를 찾을 수 없는 상태
            UserManager.shared.appStateString = "login"
        } else {
            if request.retryCount > retryLimit {
                print("🚨재시도 횟수가 너무 많습니다🚨")
            }
            completion(.doNotRetryWithError(error))
            return
        }
    }
}


