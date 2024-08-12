//
//  ChallengeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import SwiftUI

import FamilyControls
import DeviceActivity

import OnboardingFeature
import DSKit

public struct ChallengeView: View {
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
            emptyChallengeHeaderView
            listView
                .padding(.top, 20)
            //TODO: Coordinator 패턴 적용해서 이 부분 뜯어내면 좋을거 같습니다
            NavigationLink(
                destination: OnboardingContentView(isChallengeMode: true, onboardingState: 2),
                isActive: $viewModel.navigateToCreate,
                label: {
                    EmptyView()
                        .background(DSKitAsset.blackground.swiftUIColor)
                })
        }
        .customNavigationBar(title: StringLiteral.NavigationBar.challenge,
                             showBackButton: false,
                             showPointButton: true, point: viewModel.remainEarnPoint)
        .background(DSKitAsset.blackground.swiftUIColor)
        .onAppear {
            viewModel.getChallengeInfo()
        }
    }
    
    var emptyChallengeHeaderView: some View {
        ZStack(alignment: .top) {
            Image(uiImage: DSKitAsset.challengeBackground.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text(StringLiteral.Challenge.noChallengeTitle)
                    .font(.text1_medium_22)
                    .lineSpacing(22 * 1.5 - 22)
                    .foregroundStyle(DSKitAsset.whiteText.swiftUIColor)
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
            Image(uiImage: DSKitAsset.challengeBackground.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text("\(viewModel.visableStartDate) 시작부터")
                    .font(.text5_medium_16)
                    .foregroundStyle(DSKitAsset.gray1.swiftUIColor)
                    .padding(.top, 14)
                Text("\(viewModel.todayIndex + 1)일차")
                    .font(.title1_semibold_32)
                    .foregroundStyle(DSKitAsset.whiteText.swiftUIColor)
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
                    .foregroundStyle(DSKitAsset.gray1.swiftUIColor)
                Spacer()
            }
            .padding(.horizontal, 20)
            DeviceActivityReport(context, filter: filter)
                .frame(height: 72 * CGFloat(screenTimeViewModel.selectedApp.applicationTokens.count))
            Button(action: {
                isPresented = true
            }, label: {
                Image(uiImage: DSKitAsset.addAppButton.image)
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
                        .foregroundStyle(DSKitAsset.gray2.swiftUIColor)
                    Image(uiImage: isExpanded ? DSKitAsset.chevronUp.image : DSKitAsset.chevronDown.image)
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
                    .foregroundStyle(DSKitAsset.gray2.swiftUIColor)
                ZStack {
                    Circle()
                        .stroke(index == viewModel.todayIndex ? DSKitAsset.bluePurpleOpacity70.swiftUIColor : DSKitAsset.gray6.swiftUIColor, lineWidth: 2)
                        .frame(width: 44, height: 44)
                    switch viewModel.statuses[index] {
                    case "FAILURE":
                        Image(uiImage: DSKitAsset.failStar.image)
                            .resizable()
                            .frame(width: 24, height: 24)
                    case "EARNED":
                        Image(uiImage: DSKitAsset.doneStar.image)
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
                        Image(uiImage: DSKitAsset.successStar.image)
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


