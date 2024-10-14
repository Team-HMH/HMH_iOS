//
//  AuthService.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

typealias AuthService = BaseService<AuthAPI>

protocol AuthServiceType {
    
}

extension AuthService: AuthServiceType {

    
}

struct StubAuthService: AuthServiceType {
    
}



