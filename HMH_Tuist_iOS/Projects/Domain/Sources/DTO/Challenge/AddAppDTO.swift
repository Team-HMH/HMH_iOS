//
//  AddAppDTO.swift
//  Domain
//
//  Created by 류희재 on 10/29/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct AddAppRequest: Encodable {
    let apps: [Apps]
}

struct AddAppResult: Decodable {
    let apps: [Apps]
}
