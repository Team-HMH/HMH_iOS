import SwiftUI
import FamilyControls
import DeviceActivity

import Lottie

struct HomeView: View {
    
    @StateObject var usageTimeData = HomeViewModel()
    let userDefault = UserDefaults(suiteName: "gorup.HMH")
    
    @State var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .weekOfYear, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad])
    )
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .topLeading) {
                    LottieView(animation: .named("Main-A-final.json"))
                        .playing(loopMode: .autoReverse)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    VStack(alignment: .leading){
                        Text(StringLiteral.Home.usageStatusA)
                            .font(.text1_medium_22)
                            .foregroundStyle(.whiteText)
                            .frame(alignment: .topLeading)
                            .padding(EdgeInsets(top: 8,
                                                leading: 20,
                                                bottom: 0,
                                                trailing: 0))
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("목표 사용 시간 3시간 중")
                                .font(.detail4_medium_12)
                                .foregroundStyle(.gray2)
                                .frame(alignment: .leading)
                                .padding(EdgeInsets(top: 0,
                                                    leading: 20,
                                                    bottom: 0,
                                                    trailing: 0))
                            HStack {
                                DeviceActivityReport(context, filter: filter)
                                    .frame(maxHeight: 35, alignment: .leading)
                                Spacer()
                                Text("20분 남음")
                                    .font(.detail3_semibold_12)
                                    .foregroundStyle(.whiteText)
                            }
                            . padding(EdgeInsets(top: 2,
                                                 leading: 20,
                                                 bottom: 24,
                                                 trailing: 20))
                            ProgressView(value: 3, total: 10)
                                .foregroundStyle(.gray5)
                                .padding(EdgeInsets(top: 0,
                                                    leading: 20,
                                                    bottom: 0,
                                                    trailing: 20))
                                .tint(.whiteText)
                        }
                        .padding(.bottom, -20)
                    }
                }
                .padding(.bottom, 60)
                ForEach(usageTimeData.appsUsage) { appUsage  in
                    UsageTimeListItemView(appName: appUsage.appName,
                                          usageTime: Int(appUsage.usedTime), remainingTime: "\(appUsage.goalTime - appUsage.usedTime)")
                }
            }
            .background(.blackground)
        }
        
        .onAppear {
            requestAuthorization()
            usageTimeData.generateDummyData()
        }
        .background(.blackground)
    }
}

extension HomeView {
    func requestAuthorization() {
        AuthorizationCenter.shared.revokeAuthorization { result in
            switch result {
            case .success():
                break
            case .failure(let error):
                print("Error for Family Controls: \(error)")
            }
        }
    }
}

#Preview {
    HomeView()
}
