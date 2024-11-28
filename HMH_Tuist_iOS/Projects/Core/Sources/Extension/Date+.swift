//
//  Date+.swift
//  HMH_iOS
//
//  Created by 이지희 on 6/17/24.
//

import Foundation

public extension Date {
    func formattedString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

public extension String {
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
  
  
  func challengeHeaderFormattd() -> String? {
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = "yyyy-MM-dd"
    guard let date = inputDateFormatter.date(from: self) else {
      return nil
    }
    
    let outputDateFormatter = DateFormatter()
    outputDateFormatter.dateFormat = "M월 d일"
    let formattedDateString = outputDateFormatter.string(from: date)
    
    return formattedDateString
  }
  
}
