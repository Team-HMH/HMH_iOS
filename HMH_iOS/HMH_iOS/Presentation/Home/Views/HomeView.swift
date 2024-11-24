import SwiftUI
import FamilyControls
import DeviceActivity

import Amplitude
import Lottie

struct HomeView: View {
    
    // MARK: - Property
    
    
    @Binding var showGuideView :Bool
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
    @State private var currentIndex = 0
    
    var body: some View {
        ScrollView {
            main
        }
        .customNavigationBar(title: StringLiteral.NavigationBar.home,
                             showBackButton: false,
                             showPointButton: false,
                             showGuideButton: true,
                             point: 0,
                             showGuideView: $showGuideView)
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
            ZStack {
                RoundedRectangle(cornerRadius: 28)
                    .fill(LinearGradient(colors: homeViewModel.homeBanner.backgroundColors, startPoint: .leading, endPoint: .trailing))
                    .frame(height: 56)
                HStack {
                    VStack(alignment: .leading) {
                        Text(homeViewModel.homeBanner.subTitle)
                            .font(.detail4_medium_12)
                            .foregroundStyle(.whiteText)
                        Text(homeViewModel.homeBanner.title)
                            .font(.text4_semibold_16)
                            .foregroundStyle(.whiteText)
                    }
                    .padding(.vertical, 8)
                    .padding(.leading, 24)
                    Spacer()
                    AsyncImage(url: URL(string: homeViewModel.homeBanner.imageUrl)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 124, height: 64)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 16)
            HStack (alignment: .center) {
                Text("잠금 앱")
                    .font(.text5_medium_16)
                    .foregroundStyle(.gray1)
                Spacer()
                Button(action: {
                    isPresented = true
                    homeViewModel.editButtonClicked()
                }, label: {
                    Text("편집")
                        .font(.text4_semibold_16)
                        .foregroundStyle(.bluePurpleText)
                })
                .familyActivityPicker(isPresented: $isPresented,
                                      selection: screenTimeViewModel.$selectedApp)
                .onChange(of: screenTimeViewModel.selectedApp) { newSelection in
                    screenTimeViewModel.selectedApp = newSelection
                    Amplitude.instance().logEvent("complete_add_new")
                }
            }
            DeviceActivityReport(appContext, filter: appFilter)
                .frame(height: 72 * CGFloat(screenTimeViewModel.selectedApp.applicationTokens.count))
            Button(action: {
                isPresented = true
                homeViewModel.addButtonClicked()
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
            homeViewModel.getBannerInfo()
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
