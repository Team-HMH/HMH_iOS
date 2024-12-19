//
//  BaseCoordinator.swift
//  Coordinator
//
//  Created by 이지희 on 11/7/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//
import SwiftUI
import Combine

import Core

// MARK: - BaseCoordinator

/// NavigationStack을 사용할 경우 이전에 대한 정보를 모두 갖고 있기 때문에 부모 - 자식 코디네이터 불필요
public protocol CoordinatorType: AnyObject {
    associatedtype View: SwiftUI.View
    
    var navigationPath: NavigationPath { get set }
    
    func start() -> View
    
    func push(to view: any Hashable)
    func pop()
    func popToRoot()
}

extension CoordinatorType {
    func push(to view: any Hashable) {
        navigationPath.append(view)
    }
    
    func pop() {
        navigationPath.removeLast()
    }
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
