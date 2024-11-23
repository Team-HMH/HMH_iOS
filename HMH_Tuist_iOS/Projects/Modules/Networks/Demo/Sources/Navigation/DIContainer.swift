//
//  DIContainer.swift
//  NetworksDemo
//
//  Created by 류희재 on 11/23/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

typealias NavigationRoutableType = NavigationRoutable & ObservableObjectSettable

final class DIContainer: ObservableObject {
    
    var service: HMHServiceType
    var navigationRouter: NavigationRoutableType
    
    private init(
        service: HMHServiceType,
        navigationRouter: NavigationRoutableType = NavigationRouter()
    ) {
        self.service = service
        self.navigationRouter = navigationRouter
        
        navigationRouter.setObjectWillChange(objectWillChange)
    }
}

extension DIContainer {
    static let `default` = DIContainer(service: HMHService())
    static let stub = DIContainer(service: StubHMHSerivce())
}
