//
//  ChallengeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import SwiftUI

import FamilyControls
import DeviceActivity
import RealmSwift

struct ChallengeView: View {
    @StateObject var screenTimeViewModel = ScreenTimeViewModel()
    @State var viewModel: ChallengeViewModel
    @State var list = [AppDeviceActivity]()
    @State var isPresented = false
    @State private var selection = FamilyActivitySelection() 
    var challengeDays = 14
    
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
                   .onAppear { }
           }
       }
}

extension ChallengeView {
    private var main: some View {
        ScrollView {
            if viewModel.isEmptyChallenge() {
                emptyChallengeHeaderView
            } else {
                headerView
            }
            listView
        }
        .customNavigationBar(title: StringLiteral.NavigationBar.challenge,
                             showBackButton: false,
                             showPointButton: true)
        .background(.blackground)
    }
    
    var emptyChallengeHeaderView: some View {
        ZStack(alignment: .top) {
            Image(.challengeBackground)
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text(StringLiteral.Challenge.noChallengeTitle)
                    .font(.text1_medium_22)
                    .lineSpacing(22 * 1.5 - 22)
                    .foregroundStyle(.whiteText)
                    .padding(.top, 14)
                    .padding(.leading, 23)
                Spacer()
                createChallengeButton
                
            }
        }
    }
    
    var createChallengeButton: some View {
        NavigationLink(destination: OnboardingContentView()) {
            Text(StringLiteral.Challenge.createButton)
                .modifier(CustomButtonStyle())
        }
    }
    
    var headerView: some View {
        ZStack(alignment: .top) {
            Image(.challengeBackground)
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text("5월 5일 시작부터")
                    .font(.text5_medium_16)
                    .foregroundStyle(.gray1)
                    .padding(.top, 14)
                Text("1일차")
                    .font(.title1_semibold_32)
                    .foregroundStyle(.whiteText)
                    .padding(.top, 2)
                    .padding(.bottom, 32)
                challengeWeekView
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .padding(.bottom, 20)
            }
        }
    }
    
    var listView: some View {
        VStack(alignment: .center) {
            HStack (alignment: .center) {
                Text("잠금 앱")
                    .font(.text5_medium_16)
                    .foregroundStyle(.gray1)
                Spacer()
                Button("편집", action: viewModel.getChallengeInfo)
                    .font(.text4_semibold_16)
                    .foregroundStyle(.bluePurpleButton)
                    .frame(height: 48)
            }
            .padding(.horizontal, 20)
            DeviceActivityReport(context, filter: filter)
                .frame(height: 72 * CGFloat(screenTimeViewModel.selectedApp.applicationTokens.count))
            Button(action: {
                isPresented = true
            }, label: {
                Image(.addAppButton)
            })
            .familyActivityPicker(isPresented: $isPresented,
                                  selection: $selection)
            .onChange(of: selection) { newSelection in
                screenTimeViewModel.updateSelectedApp(newSelection: newSelection)
                screenTimeViewModel.saveHashValue()
                // TODO: 챌린지 만드는 시점에 설정
//                screenTimeViewModel.handleStartDeviceActivityMonitoring(interval: 1)
            }
        }
        .onAppear() {
            let getTotalTime = RealmManager.shared.localRealm.objects(TotalTime.self)
            print(getTotalTime)
            let getApp = RealmManager.shared.localRealm.objects(Appdata.self)
            print(getApp)
            selection = screenTimeViewModel.selectedApp
            filter = DeviceActivityFilter(
                segment: .daily(
                    during: Calendar.current.dateInterval(
                        of: .day, for: .now
                    ) ?? DateInterval()
                ),
                users: .all,
                devices: .init([.iPhone]),
                applications: screenTimeViewModel.selectedApp.applicationTokens,
                categories: screenTimeViewModel.selectedApp.categoryTokens
            )
        }
    }
    
    var challengeWeekView: some View {
        VStack {
            ForEach(1...challengeDays/7, id: \.self) { week in
                HStack {
                    ForEach(1...7, id: \.self) { days in
                        VStack {
                            Text("\((week - 1) * 7 + days)")
                                .font(.text6_medium_14)
                                .foregroundStyle(.gray2)
                            ZStack {
                                Circle()
                                    .stroke(.gray6, lineWidth: 2) // 테두리를 그리는 원
                                    .frame(width: 44, height: 44)
                                
                                Circle()
                                    .foregroundColor(.clear) // 내부를 채우는 원
                                    .frame(width: 44, height: 44)
                            }
                        }
                    }
                }
                .padding(.bottom, 8)
            }
        }
    }
}

#Preview {
    ChallengeView(viewModel: .init())
}
