//
//  Paths.swift
//  Networks
//
//  Created by 류희재 on 10/14/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

public enum Paths {
    
    //MARK: - Auth
    
    static let signUp = "/auth/sign-up"
    static let signIn = "/auth/sign-in"
    
    //MARK: - User
    
    static let editNickName = "/users/my/nickname"
    static let deleteAccount = "/users/my"
    static let getUserData = "/users"
    
    //MARK: - Room
    
    static let createRoom = "/rooms"
    static let getRooms = "/rooms"
    static let getRoomDetail = "/rooms/{roomId}"
    static let editRoomInfo = "/rooms/{roomId}"
    static let deleteRoom = "/rooms/{roomId}"
    static let getRoomMyInfo = "/rooms/{roomId}/my"
    static let matchRoom = "/rooms/{roomId}/match"
    static let enterRoom = "/rooms/enter"
    static let exitRoom = "/rooms/{roomId}/exit"
    static let deleteHistoryRoom = "/rooms/{roomId}/history"
}

