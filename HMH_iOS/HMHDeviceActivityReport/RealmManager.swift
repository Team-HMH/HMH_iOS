//
//  RealmManager.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/28/24.
//

import Foundation

import RealmSwift

class RealmManager {
    private init() { }
    
    static let shared: RealmManager = .init()
    
    var localRealm: Realm {
         let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.HMH")
         let realmURL = container?.appendingPathComponent("default.realm")
         let config = Realm.Configuration(fileURL: realmURL, schemaVersion: 1)
         return try! Realm(configuration: config)
     }
    
    func getData() -> [Appdata] {
           Array(localRealm.objects(Appdata.self))
       }
}
