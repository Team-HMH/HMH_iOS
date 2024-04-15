//
//  MyPageViewModel.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 4/12/24.
//

import SwiftUI

enum MyPageButtonType {
    case travel
    case market
    case term
    case info
}

class MyPageViewModel: ObservableObject {
    func getButtonTitle(type: MyPageButtonType) -> String {
        switch type {
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
    
    func getButtonImage(type: MyPageButtonType) -> String? {
        switch type {
        case .travel:
            return "map"
        case .market:
            return "market"
        case .term, .info:
            return nil
        }
    }
}
