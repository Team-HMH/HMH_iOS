//
//  Config.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/11/24.
//

import Foundation

public enum Config {
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
            static let appKey = "KAKAO_API_KEY"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found.")
        }
        return dict
    }()
    
    static let baseURL: String = "http://3.36.221.133"
    
//    static public let baseURL: String = {
//        guard let key = Config.infoDictionary[Keys.Plist.baseURL] as? String else {
//            fatalError("Base URL is not set in plist for this configuration.")
//        }
//        return key
//    }()
    
    static public let appKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.appKey] as? String else {
            fatalError("Base URL is not set in plist for this configuration.")
        }
        return key
    }()
}
