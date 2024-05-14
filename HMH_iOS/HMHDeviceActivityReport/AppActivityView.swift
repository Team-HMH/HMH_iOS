//
//  AppActivityView.swift
//  HMHDeviceActivityReport
//
//  Created by 이지희 on 4/27/24.
//

import SwiftUI
import FamilyControls

struct AppActivityView: View {
    var activityReport: ActivityReport
    var body: some View {
        Text("앱별 사용시간")
        VStack(spacing: 4) {
            List {
                Section {
                    ForEach(activityReport.apps) { eachApp in
                        ListRow(eachApp: eachApp)
                    }
                }
            }
        }
    }
}

struct ListRow: View {
    var eachApp: AppDeviceActivity
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 0) {
                if let token = eachApp.token {
                    Label(token)
                        .labelStyle(.iconOnly)
                        .offset(x: -4)
                }
                Text(eachApp.displayName)
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    HStack(spacing: 4) {
                        Text("화면 깨우기")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .frame(width: 72, alignment: .leading)
                        Text("\(eachApp.numberOfPickups)회")
                            .font(.headline)
                            .bold()
                            .frame(minWidth: 52, alignment: .trailing)
                    }
                    HStack(spacing: 4) {
                        Text("모니터링 시간")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .frame(width: 72, alignment: .leading)
                        Text(String(eachApp.duration.toString()))
                            .font(.headline)
                            .bold()
                            .frame(minWidth: 52, alignment: .trailing)
                    }
                }
            }
            HStack {
                Text("앱 ID")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Text(eachApp.id)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .bold()
                Spacer()
            }
        }
        .background(.clear)
    }
}
