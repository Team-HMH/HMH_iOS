//
//  Date+.swift
//  HMH_iOS
//
//  Created by 이지희 on 6/17/24.
//

import Foundation

extension Date {
    func formattedString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension String {
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
