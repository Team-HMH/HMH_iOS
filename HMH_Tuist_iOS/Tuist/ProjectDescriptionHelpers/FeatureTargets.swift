//
//  FeatureTargets.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 7/13/24.
//

import Foundation
import ProjectDescription

public enum FeatureTarget {
    case app   // iOSApp
    case interface  // Feature Interface
    case dynamicFramework
    case staticFramework
    case unitTest   // Unit Test
    case demo   // Feature Excutable Test
    
    public var hasFramework: Bool {
        switch self {
        case .dynamicFramework, .staticFramework: return true
        default: return false
        }
    }
    
    public var product: Product {
        switch self {
        case .app, .demo:
            return .app
        case .interface, .dynamicFramework:
            return .framework
        case .staticFramework:
            return .staticFramework
        case .unitTest:
            return .unitTests
        }
    }
    
    public var sources: SourceFilesList {
        switch self {
        case .app, .staticFramework, .dynamicFramework:
            return .sources
        case .interface:
            return .interface
        case .unitTest:
            return .unitTests
        case .demo:
            return .demoSources
        }
    }
}

