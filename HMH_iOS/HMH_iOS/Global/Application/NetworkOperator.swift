//
//  NetworkOperator.swift
//  HMH_iOS
//
//  Created by 이지희 on 6/11/24.
//

import Foundation
import RealmSwift

class NetworkOperation: Operation {

    override func main() {
        if self.isCancelled { return }

        let semaphore = DispatchSemaphore(value: 0)
        let midnightDTO = MidnightRequestDTO(finishedDailyChallenges: [])
        
        Providers.challengeProvider.request(target: .postDailyChallenge(data: midnightDTO), instance: BaseResponse<EmptyResponseDTO>.self) { result in
            semaphore.signal()
        }

        _ = semaphore.wait(timeout: .distantFuture)

        if self.isCancelled { return }
    }
}

class RealmUpdateOperation: Operation {

    override func main() {
        if self.isCancelled { return }

        let realm = try! Realm()

        try! realm.write {
            let midnightData = MidnightData()
            midnightData.challengeDate = Date().toString()
            midnightData.isSuccess = true
            realm.add(midnightData)
        }

        if self.isCancelled { return }
    }
}
