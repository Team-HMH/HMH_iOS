//
//  File.swift
//  MyPageFeature
//
//  Created by 류희재 on 11/26/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

import DSKit
import UIKit

enum MyPageButtonType {
    case travel
    case market
    case term
    case info
    
    var titleText: String {
        switch self {
        case .travel:
            return StringLiteral.MyPageButton.travel
        case .market:
            return StringLiteral.MyPageButton.market
        case .term:
            return StringLiteral.MyPageButton.term
        case .info:
            return StringLiteral.MyPageButton.info
        }
    }
    
    var imageName: String? {
        switch self {
        case .travel:
            return "map"
        case .market:
            return "market"
        case .term, .info:
            return nil
        }
    }
    
    var clickAction: Void {
        switch self {
        case .travel:
            let url = URL(string: StringLiteral.MyPageURL.term)!
            UIApplication.shared.open(url)
        case .market:
            let url = URL(string: StringLiteral.MyPageURL.info)!
            UIApplication.shared.open(url)
        default:
            break
        }
    }
}
