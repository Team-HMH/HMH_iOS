import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

enum AppState {
    case onboardingComplete
    case login
    case home
}

@main
struct HMH_iOSApp: App {
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var userManager = UserManager.shared
    
    let kakaoAPIKey = Bundle.main.infoDictionary?["KAKAO_API_KEY"] as! String
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        KakaoSDK.initSDK(appKey: kakaoAPIKey)
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color(.blackground)
                    .ignoresSafeArea()
                if loginViewModel.isLoading {
                    SplashView(viewModel: loginViewModel)
                } else {
                    if userManager.isOnboarding {
                        if userManager.isLogin {
                            TabBarView()
                        } else {
                            LoginView(viewModel: loginViewModel)
                                .onOpenURL { url in
                                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                                        _ = AuthController.handleOpenUrl(url: url)
                                    }
                                }
                        }
                    } else {
                        if userManager.isOnboardingCompleted {
                            OnboardingCompleteView()
                        } else {
                            OnboardingContentView()
                        }
                    }
                }
            }
        }
    }
}
