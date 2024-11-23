////
////  NavigationRoutingView.swift
////  NetworksDemo
////
////  Created by 류희재 on 11/23/24.
////  Copyright © 2024 HMH-iOS. All rights reserved.
////
//
//import Foundation
//import SwiftUI
//
//struct NavigationRoutingView: View {
//  
//  @EnvironmentObject var container: DIContainer
//  @State var destination: NavigationDestination
//  
//    var body: some View {
//        switch destination {
//        case let .editRoom(viewType):
//            EditRoomInfoView(
//                viewModel: .init(
//                    viewType: viewType,
//                    roomService: container.service.roomService,
//                    navigationRouter: container.navigationRouter
//                ))
//        case let .makeMission(roomInfo):
//            EditMissionView(
//                viewModel: EditMissionViewModel(
//                    roomInfo: roomInfo,
//                    navigationRouter: container.navigationRouter
//                )
//            )
//        case let .roomInfo(roomInfo, missionList):
//            CheckRoomInfoView(
//                viewModel: .init(
//                    roomInfo: roomInfo,
//                    missionList: missionList,
//                    roomService: container.service.roomService,
//                    navigationRouter: container.navigationRouter
//                )
//            )
//            
//        case .enterRoom:
//            EnterRoomView(
//                viewModel: .init(
//                    roomService: container.service.roomService,
//                    navigationRouter: container.navigationRouter
//                )
//            )
//        case let .manitoWaitingRoom(roomDetail):
//            ManitoWaitingRoomView(
//                viewModel: .init(
//                    roomService: container.service.roomService,
//                    navigationRouter: container.navigationRouter,
//                    roomDetail: roomDetail
//                )
//            )
//
//        case .myPage:
//            MyPageView(viewModel: MyPageViewModel(navigationRouter: container.navigationRouter))
//            
//        case .editUsername:
//            EditUsernameView(
//                viewModel: EditUsernameViewModel(
//                    userService: container.service.userService,
//                    navigationRouter: container.navigationRouter,
//                    windowRouter: container.windowRouter
//                )
//            )
//
//        case .matchRoom(let roomID):
//            MatchingView(
//                viewModel: MatchingViewModel(
//                    roomService: container.service.roomService,
//                    navigationRouter: container.navigationRouter,
//                    roomID: roomID
//                )
//            )
//        case .matchedRoom(let roomDetail):
//            MatchingResultView(
//                viewModel: MatchingResultViewModel(
//                    roomService: container.service.roomService,
//                    navigationRouter: container.navigationRouter,
//                    roomInfo: roomDetail
//                )
//            )
//        case .finish(let roomDetail):
//            FinishView(viewModel: FinishViewModel(roomService: container.service.roomService, navigationRouter: container.navigationRouter, roomInfo: roomDetail))
//        }
//    
//    }
//}
//
//
//extension View {
//    
//    func setSMNavigation() -> some View {
//        self.navigationDestination(for: NavigationDestination.self) { destination in
//            return NavigationRoutingView(destination: destination)
//        }
//    }
//    
//
//}
//
