//
//  AddAppDTO.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct AddAppRequest: Encodable {
    let apps: [AppInfoDTO]
    
    public init(apps: [AppInfoDTO]) {
        self.apps = apps
    }
}

public struct AddAppResult: Decodable {
    let apps: [AppInfoDTO]
}

public extension AddAppRequest {
    static var stub: Self {
        .init(apps: [.stub,.stub,.stub,.stub])
    }
}
