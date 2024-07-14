//
//  InfoPlist.swift
//  MyPlugin
//
//  Created by 류희재 on 7/13/24.
//

import ProjectDescription

//TODO: 추후 환경에 맞게 InfoPlist 수정하기
/// InfoPList를 정리해둔 파일이빈다
public extension Project {
    static let appInfoPlist: [String: Plist.Value] = [
        "BASE_URL": "$(BASE_URL)",
        "BGTaskSchedulerPermittedIdentifiers": ["com.HMH.dailyTask"],
        "CFBundleURLTypes": [
            [
                "CFBundleTypeRole": "Editor",
                "CFBundleURLSchemes": ["kakao$(KAKAO_API_KEY)"]
            ]
        ],
        "KAKAO_API_KEY": "$(KAKAO_API_KEY)",
        "LSApplicationQueriesSchemes": ["kakaokompassauth", "kakaolink"],
        "NSAppTransportSecurity": [
            "NSAllowsArbitraryLoads": true
        ],
        "UIAppFonts": ["Pretendard-Regular.otf", "Pretendard-SemiBold.otf", "Pretendard-Medium.otf"]
    ]
    
    
    static let demoInfoPlist: [String: Plist.Value] = [
        "BASE_URL": "$(BASE_URL)",
        "BGTaskSchedulerPermittedIdentifiers": ["com.HMH.dailyTask"],
        "CFBundleURLTypes": [
            [
                "CFBundleTypeRole": "Editor",
                "CFBundleURLSchemes": ["kakao$(KAKAO_API_KEY)"]
            ]
        ],
        "KAKAO_API_KEY": "$(KAKAO_API_KEY)",
        "LSApplicationQueriesSchemes": ["kakaokompassauth", "kakaolink"],
        "NSAppTransportSecurity": [
            "NSAllowsArbitraryLoads": true
        ],
        "UIAppFonts": ["Pretendard-Regular.otf", "Pretendard-SemiBold.otf", "Pretendard-Medium.otf"]
    ]
}


