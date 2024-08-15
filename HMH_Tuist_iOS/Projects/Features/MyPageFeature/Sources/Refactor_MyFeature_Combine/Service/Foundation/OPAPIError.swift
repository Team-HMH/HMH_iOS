//
//  OPAPIError.swift
//  MyPageFeatureInterface
//
//  Created by 류희재 on 8/13/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public enum OPAPIError: LocalizedError {
    case attendanceError(BaseEntity<Data>)
    
    public var errorDescription: String? {
        switch self {
        case let .attendanceError(error):
            return String(error.message.split(separator: ": ").last ?? "")
        }
    }
}
