//
//  PathExtension.swift
//  MyPlugin
//
//  Created by 류희재 on 7/13/24.
//

import ProjectDescription

/// ProjectDescription.Path의 확장을 통해
/// 프로젝트 내 경로를 보다 간결하고 직관적으로 관리하기 위한 유틸리티를 제공하는 파일

public extension ProjectDescription.Path {
    /// 기능 폴더에 대한 상대 경로를 생성
    static func relativeToFeature(_ path: String) -> Self {
        return .relativeToRoot("Projects/Features/\(path)")
    }
    
    /// 모듈 폴더에 대한 상대 경로를 생성
    static func relativeToModules(_ path: String) -> Self {
        return .relativeToRoot("Projects/Modules/\(path)")
    }
    
    // 하면함 모듈 폴더에 대한 상대 경로를 생성
    static func relativeToHMHModules(_ path: String) -> Self {
        return .relativeToRoot("Projects/HMHModules/\(path)")
    }
    
    /// 각각 앱 폴더에 대한 경로를 반환하는 속성
    static var app: Self {
        return .relativeToRoot("Projects/App")
    }
    
    /// 각각 데이터 폴더에 대한 경로를 반환하는 속성
    static var data: Self {
        return .relativeToRoot("Projects/Data")
    }
    
    /// 각각 도메인 폴더에 대한 경로를 반환하는 속성
    static var domain: Self {
        return .relativeToRoot("Projects/Domain")
    }
    
    /// 각각  코어 폴더에 대한 경로를 반환하는 속성
    static var core: Self {
        return .relativeToRoot("Projects/Core")
    }
}

