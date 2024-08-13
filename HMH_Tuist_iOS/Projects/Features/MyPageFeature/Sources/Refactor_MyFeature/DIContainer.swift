//
//  DIContainer.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

class DIContainer: ObservableObject {
    var repositorys: RepositoryType
    
    init(repositorys: RepositoryType) {
        self.repositorys = repositorys
    }
}
