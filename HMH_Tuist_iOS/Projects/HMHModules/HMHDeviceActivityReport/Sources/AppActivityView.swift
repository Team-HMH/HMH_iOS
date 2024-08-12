//
//  AppActivityView.swift
//  HMHDeviceActivityReport
//
//  Created by 이지희 on 4/27/24.
//

import SwiftUI
import FamilyControls

import Lottie

import DSKit

struct AppActivityView: View {
    var activityReport: ActivityReport
    var body: some View {
        VStack() {
            HeaderView(activityReport: activityReport)
            
                .padding(.bottom, 40)
            ForEach(activityReport.apps) { eachApp in
                ListView(eachApp: eachApp)
                    .padding(.horizontal, 20)
            }
        }
    }
}

struct HeaderView: View {
    var activityReport: ActivityReport
    //TODO: 이거 모듈간 의존성 어떻게 할지 생각하고 다시 정하기 위해서 주석처리해둠
//    @ObservedObject var screenTimeViewModel = ScreenTimeViewModel()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                LottieView(animation: .named(activityReport.titleState.isEmpty ? "Main-A-final.json" : activityReport.titleState[0]))
                    .playing(loopMode: .autoReverse)
                    .resizable()
                VStack(alignment: .leading){
                    Text(activityReport.titleState.isEmpty ? StringLiteral.Home.usageStatusA : activityReport.titleState[1])
                        .font(.text1_medium_22)
                        .foregroundStyle(DSKitAsset.whiteText.swiftUIColor)
                        .frame(alignment: .topLeading)
                        .padding(EdgeInsets(top: 8,
                                            leading: 20,
                                            bottom: 0,
                                            trailing: 0))
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("목표 사용 시간 \(convertMillisecondsToHourString(milliseconds: activityReport.totalGoalTime)) 중")
                            .font(.detail4_medium_12)
                            .foregroundStyle(DSKitAsset.gray2.swiftUIColor)
                            .frame(alignment: .leading)
                            .padding(EdgeInsets(top: 0,
                                                leading: 20,
                                                bottom: 0,
                                                trailing: 0))
                        HStack {
                            Text("\(convertMillisecondsToHourString(milliseconds: activityReport.totalDuration)) 사용")
                                .font(.title2_semibold_24)
                                .foregroundStyle(DSKitAsset.whiteText.swiftUIColor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            Text(convertMillisecondsToHourString(milliseconds: activityReport.remainTime) + " 남음")
                                .font(.detail3_semibold_12)
                                .foregroundStyle(DSKitAsset.whiteText.swiftUIColor)
                        }
                        . padding(EdgeInsets(top: 2,
                                             leading: 20,
                                             bottom: 24,
                                             trailing: 20))
                        ProgressView(value: Double(activityReport.totalDuration), total: Double(activityReport.totalGoalTime))
                            .foregroundStyle(DSKitAsset.gray5.swiftUIColor)
                            .padding(EdgeInsets(top: 0,
                                                leading: 20,
                                                bottom: 0,
                                                trailing: 20))
                            .tint(DSKitAsset.whiteText.swiftUIColor)
                    }
                    .frame(maxHeight: 83)
                }
            }
        }
        .onAppear() {
            if activityReport.totalDuration == activityReport.totalGoalTime {
                //TODO: 이거 모듈간 의존성 어떻게 할지 생각하고 다시 정하기 위해서 주석처리해둠
//                screenTimeViewModel.handleSetBlockApplication()
            }
        }
    }
}

extension HeaderView {
    func convertMillisecondsToHourString(milliseconds: Int) -> String {
        let secondsTotal = milliseconds / 1000
        let hours = secondsTotal / 3600
        let minutes = (secondsTotal % 3600) / 60
        
        if hours > 0 {
            if minutes > 0 {
                return "\(hours)시간 \(minutes)분"
            } else {
                return "\(hours)시간"
            }
        } else {
            return "\(minutes)분"
        }
    }
}

struct ListView: View {
    var eachApp: AppDeviceActivity
    
    var body: some View {
        HStack {
            if let token = eachApp.token {
                Label(token)
                    .labelStyle(.iconOnly)
                    .scaleEffect(2)
                    .padding(.trailing, 8)
            }
            VStack(alignment: .leading) {
                Text(eachApp.displayName)
                    .font(.detail3_semibold_12)
                    .foregroundStyle(DSKitAsset.gray1.swiftUIColor)
                    .padding(.bottom, 1)
                Text(String(eachApp.duration.toString()))
                    .font(.detail2_semibold_13)
                    .foregroundStyle(DSKitAsset.whiteText.swiftUIColor)
            }
            Spacer()
            Text(String(eachApp.remainTime.toString()))
                .font(.text6_medium_14)
                .foregroundStyle(DSKitAsset.whiteText.swiftUIColor)
            + Text("남음")
                .font(.text6_medium_14)
                .foregroundStyle(DSKitAsset.gray2.swiftUIColor)
        }
        .padding(.horizontal, 18)
        .frame(height: 72)
        .background(backgroundView)
    }
    
    var backgroundView: some View {
        GeometryReader { geometry in
            let remainingPercent = Double(eachApp.duration) / 6000 // 0에서 1 사이의 값으로 정규화
            let gradientColors: [Color] = [DSKitAsset.bluePurpleButton.swiftUIColor.opacity(0.4), DSKitAsset.bluePurpleButton.swiftUIColor]
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(DSKitAsset.gray7.swiftUIColor)  // RoundedRectangle에 직접 색상 적용
                LinearGradient(gradient: Gradient(colors: gradientColors),
                               startPoint: .leading,
                               endPoint: .trailing)
                .frame(width: geometry.size.width * CGFloat(remainingPercent))
            }
            .clipShape(RoundedRectangle(cornerRadius: 4)) // 모서리를 둥글게
        }
        .frame(height: 72)
    }
    
}
