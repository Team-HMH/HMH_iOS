//
//  PointStatusAsset.swift
//  ChallengeFeature
//
//  Created by 류희재 on 11/28/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI
import DSKit
import Domain

extension PointStatusEnum {
    public var buttonColor: Color {
      switch self {
      case .unearned:
        return DSKitAsset.bluePurpleButton.swiftUIColor
      case .earned:
        return DSKitAsset.bluePurpleOpacity22.swiftUIColor
      case .failure:
        return DSKitAsset.gray6.swiftUIColor
      case .none:
        return DSKitAsset.gray7.swiftUIColor
      }
    }
    
    public var titleColor: Color {
      switch self {
      case .unearned:
        return DSKitAsset.whiteBtn.swiftUIColor
      case .earned:
        return DSKitAsset.bluePurpleOpacity70.swiftUIColor
      case .failure:
        return DSKitAsset.gray2.swiftUIColor
      case .none:
        return DSKitAsset.gray3.swiftUIColor
      }
    }
}
