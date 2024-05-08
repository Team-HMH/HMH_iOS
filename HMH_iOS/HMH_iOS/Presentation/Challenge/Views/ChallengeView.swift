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
    @State var selection = FamilyActivitySelection()
    @State var isPresented = false
    
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
            ZStack(alignment: .top) {
                Image(.challengeBackground)
                VStack(alignment: .leading) {
                    Text("5월 5일 시작부터")
                        .font(.text5_medium_16)
                        .foregroundStyle(.gray1)
                        .padding(.top, 14)
                    Text("\(viewModel.data?.todayIndex ?? 1)일차")
                        .font(.title1_semibold_32)
                        .foregroundStyle(.whiteText)
                        .padding(.top, 2)
                    
                    ChallengeWeekListView()
                        .frame(width: 338, height: 66)
                        .padding(.bottom, 20)
                    
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
                        ChallengeAppListView()
                        ChallengeAppListView()
                        Button(action: selectApp, label: {
                            Image(.addAppButton)
                        })
                        .familyActivityPicker(isPresented: $isPresented,
                                              selection: $selection)
                        .onChange(of: selection) { newSelection in
                            let applications = selection.applications
                            let categories = selection.categories
                            let webDomains = selection.webDomains
                        }
                    }
                }
                
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 20))
                
            }
            
            
        }
        .customNavigationBar(title: StringLiteral.NavigationBar.challenge,
                             showBackButton: false,
                             showPointButton: true)
        .background(.blackground)
    }
}


struct ChallengeWeekListView: View {
    var body: some View {
        HStack {
            ForEach(1...7, id: \.self) { dayIndex in
                VStack {
                    Text("\(dayIndex)")
                        .font(.text6_medium_14)
                        .foregroundStyle(.gray2)
                    ZStack {
                        Circle()
                            .stroke(.gray6, lineWidth: 2) // 테두리를 그리는 원
                            .frame(width: 45, height:45)
                        
                        Circle()
                            .foregroundColor(.clear) // 내부를 채우는 원
                            .frame(width: 44, height: 44)
                    }
                }
            }
        }
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
