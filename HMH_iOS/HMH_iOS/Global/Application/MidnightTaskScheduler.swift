//
//  MidnightTaskScheduler.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/26/24.
//

import Foundation

class MidnightTaskScheduler: ObservableObject {
    var timer: Timer?
    
    init() {
        scheduleMidnightTask()
    }
    
    func scheduleMidnightTask() {
        let nextMidnight = nextMidnightDate()
        let interval = nextMidnight.timeIntervalSinceNow
        
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(executeMidnightTask), userInfo: nil, repeats: false)
        print("Timer scheduled to fire at: \(nextMidnight)")
    }
    
    @objc func executeMidnightTask() {
        saveDataToLocalDatabase()
        scheduleMidnightTask()
    }
    
    func nextMidnightDate() -> Date {
        let now = Date()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        
        let nextMidnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .nextTime)!
        return nextMidnight
    }
    
    func saveDataToLocalDatabase() {
        print("Data saved to local database.")
        // 백그라운드에서 실행할 API 연결
    }
}
