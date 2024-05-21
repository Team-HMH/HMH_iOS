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
    @State private var isLoading: Bool = true
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var userManager = UserManager.shared
    
    let kakaoAPIKey = Bundle.main.infoDictionary?["KAKAO_API_KEY"] as! String
    
    init() {
        KakaoSDK.initSDK(appKey: kakaoAPIKey)
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color(.blackground)
                    .ignoresSafeArea()
                if isLoading {
                    SplashView(isLoading: $isLoading)
                } else {
                    if userManager.isOnboarding {
                        if userManager.isLogin {
                            TabBarView()
                        } else {
                            LoginView()
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
