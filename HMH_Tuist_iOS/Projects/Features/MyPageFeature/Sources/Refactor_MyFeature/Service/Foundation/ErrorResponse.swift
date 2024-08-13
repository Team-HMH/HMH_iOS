//
//  ErrorResponse.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public struct ErrorResponse: Decodable, Equatable {
    public let statusCode: String
    public let responseMessage: String
}
