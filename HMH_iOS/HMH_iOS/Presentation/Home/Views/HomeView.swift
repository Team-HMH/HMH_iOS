import SwiftUI
import FamilyControls
import DeviceActivity

import Lottie

struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    let userDefault = UserDefaults(suiteName: "gorup.HMH")
    
    @State var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad])
    )
    @State var appContext: DeviceActivityReport.Context = .init(rawValue: "App Activity")
    @State var appFilter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad]),
        applications: ScreenTimeViewModel.shared.selectionToDiscourage.applicationTokens,
        categories: ScreenTimeViewModel.shared.selectionToDiscourage.categoryTokens
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
                DeviceActivityReport(appContext, filter: appFilter)
            }
            .background(.blackground)
            .customNavigationBar(title: StringLiteral.NavigationBar.home,
                                 showBackButton: false,
                                 showPointButton: false)
        }
        .onAppear {
            ScreenTimeViewModel.shared.requestAuthorization()
            
            appFilter = DeviceActivityFilter(
                segment: .daily(
                    during: Calendar.current.dateInterval(
                        of: .day, for: .now
                    ) ?? DateInterval()
                ),
                users: .all,
                devices: .init([.iPhone]),
                applications: ScreenTimeViewModel.shared.selectionToDiscourage.applicationTokens,
                categories: ScreenTimeViewModel.shared.selectionToDiscourage.categoryTokens
            )
        }
        .background(.blackground)
    }
}

#Preview {
    HomeView()
}
