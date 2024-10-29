//
//  ReissueService.swift
//  Networks
//
//  Created by 류희재 on 10/28/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

typealias ReissueAPIService = BaseService<AuthAPI>

protocol ReissueAPIServiceType {
    
}

extension ReissueAPIService: ReissueAPIServiceType {

    
}

struct StubReissueAPIService: ReissueAPIServiceType {
    
}
