//
//  MidnightTaskScheduler.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/26/24.
//

import BackgroundTasks
import CoreData

class MidnightTaskScheduler {
    var timer: Timer?
    
    init() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.example.app.refresh", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        scheduleMidnightTask()
    }
    
    func scheduleMidnightTask() {
        let request = BGAppRefreshTaskRequest(identifier: "com.example.app.refresh")
        request.earliestBeginDate = nextMidnight() // 다음 자정에 실행되도록 설정
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Unable to submit task: \(error)")
        }
    }
    
    func handleAppRefresh(task: BGAppRefreshTask) {
        // 데이터 저장 작업 실행
        saveDataToLocalDatabase()
        
        // 작업이 끝나면 새로 예약
        scheduleMidnightTask()
        
        task.setTaskCompleted(success: true)
    }
    
    func nextMidnight() -> Date {
        let now = Date()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        
        let nextMidnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .nextTime)!
        return nextMidnight
    }
    
    func saveDataToLocalDatabase() {
        
    }
}

