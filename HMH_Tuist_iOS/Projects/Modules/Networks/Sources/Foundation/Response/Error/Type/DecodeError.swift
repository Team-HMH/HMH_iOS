//
//  DecodeError.swift
//  Networks
//
//  Created by 류희재 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

extension HMHNetworkError {
    public enum DecodeError: Error, Equatable {
        case failed
        case dataIsNil
        
        var description: String {
            switch self {
            case .failed:
                return "디코딩에 실패했습니다"
            case .dataIsNil:
                return "데이터가 존재하지 않습니다."
            }
        }
    }
}
