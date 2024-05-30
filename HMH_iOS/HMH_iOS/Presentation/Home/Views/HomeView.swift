import SwiftUI
import FamilyControls
import DeviceActivity

import Lottie

struct HomeView: View {
    @StateObject var screenTimeViewModel = ScreenTimeViewModel()
    @StateObject var homeViewModel = HomeViewModel()
    
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
        devices: .init([.iPhone, .iPad])
    )
    
    var body: some View {
        ScrollView {
            main
        }
        .customNavigationBar(title: StringLiteral.NavigationBar.home,
                             showBackButton: false,
                             showPointButton: false)
        .background(.blackground)
        .onAppear {
            screenTimeViewModel.requestAuthorization()
            
            appFilter = DeviceActivityFilter(
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
}

extension HomeView {
    var main: some View {
        VStack {
            DeviceActivityReport(context, filter: filter)
                .frame(minHeight: 395)
            DeviceActivityReport(appContext, filter: appFilter)
                .frame(height: 80 * CGFloat(screenTimeViewModel.selectedApp.applicationTokens.count))
                .padding(.bottom, 20)
        }
    }
}


//#Preview {
//    HomeView()
//}
