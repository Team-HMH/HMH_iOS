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

// MARK: - BaseCoordinator 프로토콜
public protocol CoordinatorType: AnyObject {
    
    var parentCoordinator: (any CoordinatorType)? { get set }
    var navigationPath: NavigationPath { get set }
    
    func start() -> AnyView
    
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
