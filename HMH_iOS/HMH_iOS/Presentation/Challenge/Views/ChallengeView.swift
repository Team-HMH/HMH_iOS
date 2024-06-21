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
        .showToast(toastType: .pointWarn, isPresented: $viewModel.isToastPresented)
    }
}

extension ChallengeView {
    private var main: some View {
        ScrollView {
            if viewModel.challengeType == .empty {
                emptyChallengeHeaderView
            } else {
                headerView
            }
            listView
            NavigationLink(
                destination: OnboardingContentView(isChallengeMode: true, onboardingState: 2),
                isActive: $viewModel.navigateToCreate,
                label: {
                    EmptyView()
                })
        }
        .customNavigationBar(title: StringLiteral.NavigationBar.challenge,
                             showBackButton: false,
                             showPointButton: true, point: viewModel.remainEarnPoint)
        .background(.blackground)
        .onAppear {
            viewModel.getChallengeInfo()
            viewModel.getEarnPoint()
        }
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
        Button(action: {
            viewModel.challengeButtonTapped()
        }, label: {
            Text(StringLiteral.Challenge.createButton)
                .modifier(CustomButtonStyle())
        }
        )
    }
    
    var headerView: some View {
        ZStack(alignment: .top) {
            Image(.challengeBackground)
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text("\(viewModel.visableStartDate) 시작부터")
                    .font(.text5_medium_16)
                    .foregroundStyle(.gray1)
                    .padding(.top, 14)
                Text("\(viewModel.todayIndex + 1)일차")
                    .font(.title1_semibold_32)
                    .foregroundStyle(.whiteText)
                    .padding(.top, 2)
                    .padding(.bottom, 32)
                if viewModel.challengeType != .empty {
                    challengeWeekView
                        .frame(width: UIScreen.main.bounds.width * 0.9)
                        .padding(.bottom, 20)
                }
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
                                  selection: screenTimeViewModel.$selectedApp)
            .onChange(of: screenTimeViewModel.selectedApp) { newSelection in
                screenTimeViewModel.selectedApp = newSelection
            }
        }
        .onAppear() {
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
        VStack(alignment: .leading) {
            if viewModel.days > 0 {
                ForEach(1...min(isExpanded ? (viewModel.days + 6) / 7 : 2, (viewModel.days + 6) / 7), id: \.self) { week in
                    challengeWeekRow(week: week)
                }
            }
            if viewModel.challengeType == .large {
                expandButton()
            }
        }
    }
    
    @ViewBuilder
    private func challengeWeekRow(week: Int) -> some View {
        HStack {
            ForEach(1...7, id: \.self) { day in
                challengeDayCell(week: week, day: day)
            }
        }
        .padding(.bottom, 8)
    }
    
    @ViewBuilder
    private func expandButton() -> some View {
        HStack {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }, label: {
                HStack {
                    Text(isExpanded ? "접기" : "펼치기")
                        .font(.detail4_medium_12)
                        .foregroundStyle(.gray2)
                    Image(isExpanded ? .chevronUp : .chevronDown)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 8, height: 9)
                }
                .frame(width: 57, height: 31)
            })
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func challengeDayCell(week: Int, day: Int) -> some View {
        let index = (week - 1) * 7 + day - 1
        if index < viewModel.statuses.count {
            VStack {
                Text("\(index + 1)")
                    .font(.text6_medium_14)
                    .foregroundStyle(.gray2)
                ZStack {
                    Circle()
                        .stroke(index == viewModel.todayIndex ? .bluePurpleOpacity70 : .gray6, lineWidth: 2)
                        .frame(width: 44, height: 44)
                    switch viewModel.statuses[index] {
                    case "FAILURE":
                        Image(.failStar)
                            .resizable()
                            .frame(width: 24, height: 24)
                    case "EARNED":
                        Image(.doneStar)
                    case "UNEARNED":
                        let gradient = LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color(red: 61/255, green: 23/255, blue: 211/255, opacity: 0), location: 0),
                                .init(color: Color(red: 61/255, green: 23/255, blue: 211/255, opacity: 0.4), location: 1)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        gradient
                            .mask(Circle().frame(width: 44, height: 44))
                            .frame(width: 44, height: 44)
                        Image(.successStar)
                            .resizable()
                            .frame(width: 24, height: 24)
                    default:
                        EmptyView()
                    }
                }
            }
        }
    }
}




#Preview {
    ChallengeView(viewModel: .init())
}


