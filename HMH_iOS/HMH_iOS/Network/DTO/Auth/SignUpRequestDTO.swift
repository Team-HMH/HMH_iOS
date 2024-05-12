//
//  SignUpRequestDTO.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/14/24.
//

import Foundation

struct SignUpRequestDTO: Codable {
    let socialPlatform: String
    let name: String
    let onboarding: Onboarding
    let challenge: Challenge
}

struct Onboarding: Codable {
    let averageUseTime: String
    let problem: [String]
}

struct Challenge: Codable {
    let period: Int
    let goalTime: Int
    let apps: [Apps]
}

struct Apps: Codable {
    let appCode: String
    let goalTime: Int
}
