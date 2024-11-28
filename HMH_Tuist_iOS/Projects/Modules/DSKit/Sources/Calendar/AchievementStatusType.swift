//
//  AchievementStatusType.swift
//  DSKit
//
//  Created by 이지희 on 10/31/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation

public enum AchievementStatusType: String {
  case fail = "FAILURE"
  case earned = "EARNED"
  case unearned = "UNEARNED"
  
  init(from stringValue: String) {
      self = AchievementStatusType(rawValue: stringValue.uppercased()) ?? .unearned
  }
}
