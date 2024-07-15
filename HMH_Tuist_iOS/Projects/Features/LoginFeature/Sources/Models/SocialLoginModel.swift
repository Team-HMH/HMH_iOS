//
//  AppleLoginModel.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/5/24.
//

import Foundation

struct SocialLoginInfo: Codable {
    var platform: String?
    var idToken: String?
    var name: String?
}
