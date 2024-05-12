//
//  ChallengeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import SwiftUI
import FamilyControls

struct ChallengeView: View {
    @State var viewModel: ChallengeViewModel
    @State var list = [AppDeviceActivity]()
    @State var isPresented = false
    @State private var selection = FamilyActivitySelection() {
        didSet {
            ScreenTimeViewModel.shared.selectionToDiscourage = selection
        }
    }
    var challengeDays = 14
    
    public init(viewModel: ChallengeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        main
            .onAppear {
                viewModel.generateDummyData()
            }
    }
}

extension ChallengeView {
    private var main: some View {
        ScrollView {
            headerView
            listView
        }
        .customNavigationBar(title: StringLiteral.NavigationBar.challenge,
                             showBackButton: false,
                             showPointButton: true)
        .background(.blackground)
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
                Text("\(viewModel.data?.todayIndex ?? 1)일차")
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
                Button("편집", action: viewModel.edit)
                    .font(.text4_semibold_16)
                    .foregroundStyle(.bluePurpleButton)
            }
            .frame(height: 48)
            if (selection.applicationTokens.count > 0 || selection.categoryTokens.count > 0) {
                ForEach(Array(selection.applicationTokens), id: \.self) { token in
                    HStack {
                        Label(token)
                            .labelStyle(.iconOnly)
                            .scaleEffect(1.5)
                        Label(token)
                            .labelStyle(.titleOnly)
                            .font(.text5_medium_16)
                            .foregroundStyle(.gray2)
                        Spacer()
                        Text("2시간")
                    }
                    .frame(height: 62)
                }
            }
            Button(action: {
                isPresented = true
            }, label: {
                Image(.addAppButton)
            })
            .familyActivityPicker(isPresented: $isPresented,
                                  selection: $selection)
            .onChange(of: selection) { newSelection in
                selection = newSelection
                selection.applications.forEach { application in
                    list.append(AppDeviceActivity(id: application.bundleIdentifier ?? "nil",
                                                  displayName: application.localizedDisplayName ?? "nil",
                                                  token: application.token!))
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 20))
        .onAppear() {
            selection = ScreenTimeViewModel.shared.selectionToDiscourage
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
