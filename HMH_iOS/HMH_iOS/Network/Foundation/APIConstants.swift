//
//  APIConstants.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/11/24.
//

import Foundation
import Moya

struct APIConstants{
    static let contentType = "Content-Type"
    static let applicationJSON = "application/json"
    static let auth = "Authorization"
    // 아래 주석은 네트워크 연결할 때 해제해주세요!
    static var accessToken: String {
        let socialToken = "Bearer " + UserManager.shared.accessToken
        return socialToken
    }
    static var refreshToken: String {
        let socialToken = "Bearer " + UserManager.shared.refreshToken
        return socialToken
    }
    static var appleAccessToken: String {
        let socialToken = UserManager.shared.socialToken ?? ""
        return socialToken
    }

    static let OS = "OS"
    static let iOS = "iOS"
}

extension APIConstants{
    static let hasSocialTokenHeader = [contentType: applicationJSON,
                                             auth : appleAccessToken]
    static let hasTokenHeader = [contentType: applicationJSON,
                                          OS: iOS,
                                       auth : accessToken]
    static let hasAccessTokenHeader = [contentType: applicationJSON,
                                       auth : accessToken]
    static let hasRefreshTokenHeader = [contentType: applicationJSON,
                                              auth : refreshToken]
    static let signUpHeader = [contentType: applicationJSON,
                                     auth : appleAccessToken,
                                        OS: iOS,]
}
