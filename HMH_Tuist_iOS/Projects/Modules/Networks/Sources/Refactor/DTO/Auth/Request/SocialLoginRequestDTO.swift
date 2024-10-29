//
//  SocialLoginRequestDTO.swift
//  Networks
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct SocialLoginRequest: Codable {
    let socialPlatform: String
    
    public init(socialPlatform: String) {
        self.socialPlatform = socialPlatform
    }
}
