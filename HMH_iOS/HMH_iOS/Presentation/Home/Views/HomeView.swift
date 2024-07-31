import SwiftUI
import FamilyControls
import DeviceActivity

import Lottie

struct HomeView: View {
    
    // MARK: - Property
    
    @StateObject var screenTimeViewModel = ScreenTimeViewModel()
    @StateObject var homeViewModel = HomeViewModel()
    @State private var isPresented = false
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
    @State var appContext: DeviceActivityReport.Context = .init(rawValue: "Challenge Activity")
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
            DeviceActivityReport(context, filter: filter)
                .frame(minHeight: 395)
            listView
                .padding(.vertical, 26)
                .padding(.horizontal, 20)
        }
    }
    
    var listView: some View {
        VStack(alignment: .center) {
            HStack (alignment: .center) {
                Text("잠금 앱")
                    .font(.text5_medium_16)
                    .foregroundStyle(.gray1)
                Spacer()
                Button(action: {
                    isPresented = true
                }, label: {
                    Text("편집")
                        .font(.text4_semibold_16)
                        .foregroundStyle(.bluePurpleText)
                })
                .familyActivityPicker(isPresented: $isPresented,
                                      selection: screenTimeViewModel.$selectedApp)
                .onChange(of: screenTimeViewModel.selectedApp) { newSelection in
                    screenTimeViewModel.selectedApp = newSelection
                }
            }
            DeviceActivityReport(appContext, filter: appFilter)
                .frame(height: 72 * CGFloat(screenTimeViewModel.selectedApp.applicationTokens.count))
            Button(action: {
                isPresented = true
            }, label: {
                Image(.appAddBtn)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            })
            .frame(maxWidth: .infinity)
            .familyActivityPicker(isPresented: $isPresented,
                                  selection: screenTimeViewModel.$selectedApp)
            .onChange(of: screenTimeViewModel.selectedApp) { newSelection in
                screenTimeViewModel.selectedApp = newSelection
            }
        }
        .onAppear() {
            homeViewModel.getDailyChallenge()
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
