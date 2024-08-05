//
//  ChallengeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//
import SwiftUI

import FamilyControls
import DeviceActivity

struct ChallengeView: View {
    @StateObject var screenTimeViewModel = ScreenTimeViewModel()
    @ObservedObject var viewModel: ChallengeViewModel
    
    @State private var isExpanded = false
    @State private var isPresented = false
    @State private var isShowGuideView = false
    
    @State var context: DeviceActivityReport.Context = .init(rawValue: "Challenge Activity")
    @State var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad])
    )
    
    public init(viewModel: ChallengeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            main
        }
        .showToast(toastType: .pointWarn, isPresented: $viewModel.isToastPresented)
    }
}

extension ChallengeView {
    private var main: some View {
        ScrollView {
            if viewModel.todayIndex < 0 {
                AnyView(EmptyChallengeHeaderView(viewModel: viewModel))
            } else {
                AnyView(ChallengeHeaderView(viewModel: viewModel))
            }
            NavigationLink(
                destination: OnboardingContentView(isChallengeMode: true, onboardingState: .periodSelect),
                isActive: $viewModel.navigateToCreate,
                label: {
                    EmptyView()
                        .background(.blackground)
                })
        }
        .customNavigationBar(title: StringLiteral.NavigationBar.challenge,
                             showBackButton: false,
                             showPointButton: true,
                             showGuideButton: false,
                             point: viewModel.remainEarnPoint,
                             showGuideView: $isShowGuideView)
        .background(.blackground)
        .onAppear {
            viewModel.getChallengeInfo()
        }
    }
}
