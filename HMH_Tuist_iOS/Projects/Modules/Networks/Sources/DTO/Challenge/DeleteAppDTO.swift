//
//  DeleteAppRequestDTO.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/16/24.
//

import Foundation

public struct DeleteAppRequest: Encodable {
    let appCode: String
    
    public init(appCode: String) {
        self.appCode = appCode
    }
}

public extension DeleteAppRequest {
    static var stub: Self {
        .init(appCode: "######")
    }
}
