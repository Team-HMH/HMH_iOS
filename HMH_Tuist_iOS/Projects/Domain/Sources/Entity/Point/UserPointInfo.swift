//
//  UsePointInfo.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct UserPointInfo {
    let usagePoint: Int
    let remainPoint: Int
    
    public init(usagePoint: Int, remainPoint: Int) {
        self.usagePoint = usagePoint
        self.remainPoint = remainPoint
    }
}
