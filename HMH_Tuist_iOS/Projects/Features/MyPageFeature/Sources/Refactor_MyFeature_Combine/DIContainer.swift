//
//  DIContainer.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

class DIContainer: ObservableObject {
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}

