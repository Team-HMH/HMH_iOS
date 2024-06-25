import SwiftUI
import FamilyControls
import DeviceActivity

import Lottie

struct HomeView: View {
    @StateObject var screenTimeViewModel = ScreenTimeViewModel()
    @StateObject var homeViewModel = HomeViewModel()

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
                             showPointButton: false, point: 0)
        .background(.blackground)
        .task {
            await loadData()
        }
        
    }
}

extension HomeView {
    var main: some View {
        VStack {
            DeviceActivityReport(appContext, filter: appFilter)
                .frame(maxWidth: .infinity, minHeight: 400 + 80 * CGFloat(screenTimeViewModel.selectedApp.applicationTokens.count), maxHeight: .infinity)
                .padding(.bottom, 20)
        }
    }
    
    @MainActor
    func loadData() async {
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



//#Preview {
//    HomeView()
//}
