//
//  Paths.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

public enum Paths {
    
    //MARK: - Auth
    
    static let signUp = "api/v2/user/signup"
    static let socialLogin = "api/v1/user/login"
    static let tokenRefresh = "api/v1/user/reissue"
    
    //MARK: - User
    
    static let logout = "api/v1/user/logout"
    static let deleteAccount = "api/v1/user"
    static let getUserData = "api/v1/user"
    static let getCurrentPoint = "api/v1/user/point"
    
    
    //MARK: - Point
    
    static let getUsagePoint = "api/v1/point/use"
    static let patchEarnPoint = "api/v1/point/earn"
    static let getEarnPoint = "api/v1/point/earn"
    static let getPointList = "api/v1/point/list"
    static let patchPointUse = "api/v2/point/use"
    
    //MARK: - Challenge
    
    static let getdailyChallenge =  "api/v2/challenge/home"
    static let postSuccesChallenge = "api/v2/challenge/daily/success"
    static let createChallenge = "api/v2/challenge"
    static let getLockChallenge = "api/v2/user/daily/lock"
    static let postLockChallenge = "api/v2/user/daily/lock"
    static let deleteApp = "api/v1/challenge/app"
    static let getChallenge = "api/v2/challenge"
    static let addApp = "api/v1/challenge/app"
}

