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
        "BASE_URL": "https://api.openweathermap.org/data/2.5",
        "API_KEY": "7618d35ff394f5dd39212928a3a4692f",
        "CFBundleShortVersionString": "1.0.0",
        "CFBundleDevelopmentRegion": "ko",
        "CFBundleVersion": "1",
        "CFBundleIdentifier": "com.Weather-iOS.$(PRODUCT_MODULE_NAME)",
        "CFBundleDisplayName": "Weather-iOS",
        "UILaunchStoryboardName": "LaunchScreen",
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ],
                ]
            ]
        ],
        "UIAppFonts": [
            "Item 0": "SF-Pro-Display-Thin.otf",
            "Item 1": "SF-Pro-Display-Regular.otf",
            "Item 2": "SF-Pro-Display-Bold.otf",
            "Item 3": "SF-Pro-Display-Medium.otf",
            "Item 4": "SF-Pro-Display-Light.otf",
        ],
        "App Transport Security Settings": ["Allow Arbitrary Loads": true],
        "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
        "ITSAppUsesNonExemptEncryption": false,
    ]
    
    static let demoInfoPlist: [String: Plist.Value] = [
      "CFBundleShortVersionString": "1.0.0",
      "CFBundleDevelopmentRegion": "ko",
      "CFBundleVersion": "1",
      "CFBundleIdentifier": "com.Weather-iOS.test",
      "CFBundleDisplayName": "Weather-iOS-Test",
      "UILaunchStoryboardName": "LaunchScreen",
      "UIApplicationSceneManifest": [
          "UIApplicationSupportsMultipleScenes": false,
          "UISceneConfigurations": [
              "UIWindowSceneSessionRoleApplication": [
                  [
                      "UISceneConfigurationName": "Default Configuration",
                      "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                  ],
              ]
          ]
      ],
      "UIAppFonts": [
          // FIXME: - 폰트 추가 후 수정
          //                "Item 0": "Pretendard-Black.otf",
          //                "Item 1": "Pretendard-Bold.otf",
          //                "Item 2": "Pretendard-ExtraBold.otf",
          //                "Item 3": "Pretendard-ExtraLight.otf",
          //                "Item 4": "Pretendard-Light.otf",
          //                "Item 5": "Pretendard-Medium.otf",
          //                "Item 6": "Pretendard-Regular.otf",
          //                "Item 7": "Pretendard-SemiBold.otf",
          //                "Item 8": "Pretendard-Thin.otf"
      ],
      "App Transport Security Settings": ["Allow Arbitrary Loads": true],
      "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
      "ITSAppUsesNonExemptEncryption": false,
      "UIUserInterfaceStyle": "Dark",
      "CFBundleURLTypes": [
          [
              "CFBundleTypeRole": "Editor",
              "CFBundleURLName": "sopt-makers",
              "CFBundleURLSchemes": ["sopt-makers"]
          ]
      ],
      "UIBackgroundModes": ["remote-notification"]
  ]
}


