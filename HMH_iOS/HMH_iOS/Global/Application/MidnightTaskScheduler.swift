//
//  MidnightTaskScheduler.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/26/24.
//

import BackgroundTasks
import CoreData

class MidnightTaskScheduler: ObservableObject {
    var timer: Timer?
    
    init() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "midnight.com", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        scheduleMidnightTask()
    }
    
    func scheduleMidnightTask() {
        let request = BGAppRefreshTaskRequest(identifier: "midnight.com")
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
        print("save save")
    }
    
    func testTask() {
        timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(executeTestTask), userInfo: nil, repeats: false)
    }
    
    @objc func executeTestTask() {
        saveDataToLocalDatabase()
        scheduleMidnightTask()
        // task.setTaskCompleted(success: true) 부분은 실제로 task를 필요로 하지만, 여기서는 모의 task로 대체
        print("Task completed successfully.")
    }
}


