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
    @State var isPresented = false
    @State private var selection = FamilyActivitySelection() {
        didSet {
            ScreenTimeViewModel.shared.selectionToDiscourage = selection
        }
    }
    
    
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
                ChallengeWeekListView()
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
                Button("편집", action: edit)
                    .font(.text4_semibold_16)
                    .foregroundStyle(.bluePurpleButton)
            }
            .frame(height: 48)
            if (selection.applicationTokens.count > 0 || selection.categoryTokens.count > 0) {
                ForEach(Array(selection.applicationTokens), id: \.self) {
                    token in
                    HStack {
                        Label(token)
                            .labelStyle(.iconOnly)
                            .scaleEffect(1.5)
                        
                        Label(token)
                            .labelStyle(.titleOnly)
                            .font(.text5_medium_16)
                            .foregroundStyle(.red)
                        Spacer()
                        Text("2시간")
                    }
                    .frame(height: 72)
                }
            } else {
                Text("선택 앱 없음")
                    .foregroundStyle(.bluePurpleText)
            }
            Button(action: selectApp, label: {
                Image(.addAppButton)
            })
            .familyActivityPicker(isPresented: $isPresented,
                                  selection: $selection)
            .onChange(of: selection) { newSelection in
                selection = newSelection
                var list: [AppDeviceActivity] = []
                newSelection.applications.forEach { app in
                    list.append(AppDeviceActivity(id: app.bundleIdentifier ?? "no value",
                                                  displayName: app.localizedDisplayName ?? "no value",
                                                  token: app.token!))
                }
                
            }
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 20))
        .onAppear() {
            //MARK: 사용자가 기존에 설정한 제한 앱 불러오기
            selection = ScreenTimeViewModel.shared.selectionToDiscourage
             }
    }
}


struct ChallengeWeekListView: View {
    var body: some View {
        VStack {
            ForEach(1...2, id: \.self) { week in
                HStack {
                    ForEach(1...7, id: \.self) { dayIndex in
                        VStack {
                            Text("\(dayIndex)")
                                .font(.text6_medium_14)
                                .foregroundStyle(.gray2)
                            ZStack {
                                Circle()
                                    .stroke(.gray6, lineWidth: 2) // 테두리를 그리는 원
                                    .frame(width: 44.adjusted, height: 44.adjusted)
                                
                                Circle()
                                    .foregroundColor(.clear) // 내부를 채우는 원
                                    .frame(width: 44.adjusted, height: 44.adjusted)
                            }
                        }
                    }
                }
                .padding(.bottom, 8)
            }
        }
    }
}

struct ChallengeAppListView: View {
    var body: some View {
        HStack {
            Image(systemName: "square.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.trailing, 12)
                .padding(.leading, 4)
            Text("앱 이름")
                .font(.text5_medium_16)
                .foregroundStyle(.gray2)
            Spacer()
            Text("1시간 20분")
                .font(.text6_medium_14)
                .foregroundStyle(.whiteText)
        }
        .frame(height: 72)
    }
}


extension ChallengeView {
    private func edit() {
        
    }
    
    private func selectApp() {
        print("tap Select App Button")
        isPresented = true
    }
}

#Preview {
    ChallengeView(viewModel: .init())
}
