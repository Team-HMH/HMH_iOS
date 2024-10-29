//
//  Paths.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

public enum Paths {
    
    //MARK: - Auth
    
    static let signUp = "user/signup"
    static let socialLogin = "user/login"
    static let tokenRefresh = "user/reissue"
    
    //MARK: - User
    
    static let logout = "user/logout"
    static let deleteAccount = "user"
    static let getUserData = "/users"
    static let getCurrentPoint = "user/point"
    
    //MARK: - Point
    
    static let getUsagePoint = "point/use"
    static let patchEarnPoint = "point/earn"
    static let getEarnPoint = "point/earn"
    static let getPointList = "point/list"
    static let patchPointUse = "point/use"
    
    //MARK: - Point
    
    static let createChallenge = "challenge"
    static let dailyChallengeFail = "dailychallenge/failure"
    static let getChallenge = "challenge"
    static let getdailyChallenge =  "challenge/home"
    static let addApp = "challenge/app"
    static let deleteApp = "challenge/app"
    static let postDailyChallenge = "challenge/daily/success"
    
}

