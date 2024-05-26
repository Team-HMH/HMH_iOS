//
//  DailyChallenge+CoreDataProperties.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/26/24.
//
//

import Foundation
import CoreData


extension DailyChallengeModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyChallenge> {
        return NSFetchRequest<DailyChallenge>(entityName: "DailyChallenge")
    }

    @NSManaged public var date: String?
    @NSManaged public var is_send: Bool
    @NSManaged public var challenge: NSObject?
    @NSManaged public var app_data: AppData?

}

extension DailyChallengeModel : Identifiable {

}
