////
////  NavigationRouter.swift
////  NetworksDemo
////
////  Created by 류희재 on 11/23/24.
////  Copyright © 2024 HMH-iOS. All rights reserved.
////
//
import Foundation
import Combine

import Combine

protocol ObservableObjectSettable: AnyObject {
  var objectWillChange: ObservableObjectPublisher? { get set }
  func setObjectWillChange(_ objectWillChange: ObservableObjectPublisher?)
}

extension ObservableObjectSettable {
  func setObjectWillChange(_ objectWillChange: ObservableObjectPublisher?) {
    self.objectWillChange = objectWillChange
  }
}

protocol NavigationRoutable {
  var destinations: [NavigationDestination] { get set }
  
  func push(to view: NavigationDestination)
  func pop()
  func popToRootView()
}


class NavigationRouter: NavigationRoutable, ObservableObjectSettable {
  
  var objectWillChange: ObservableObjectPublisher?
  
  var destinations: [NavigationDestination] = [] {
    didSet {
      objectWillChange?.send()
    }
  }
  
  func push(to view: NavigationDestination) {
    destinations.append(view)
  }
  
  func pop() {
    _ = destinations.popLast()
  }
  
  func popToRootView() {
    destinations = []
  }
}


