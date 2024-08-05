//
//  OnboardingViewModel.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI
import FamilyControls

enum OnboardingState: Int {
    case timeSurveySelect = 0
    case problemSurveySelect
    case periodSelect
    case appGoalTimeSelect
    case permissionSelect
    case appSelect
}

class OnboardingViewModel: ObservableObject {
    
    var screenViewModel: ScreenTimeViewModel
    
    @Published
    var surveyButtonItems: [[SurveyButtonInfo]]
    
    var problems: [String]
    
    @Published
    var onboardingState: OnboardingState
    
    @Published
    var isCompleted: Bool
    
    @Published
    var isPickerPresented: Bool = false
    
    @Published
    var isOnboardingError : Bool = false
    
    @Published
    var isCompletePresented: Bool = false
    
    @Published
    var selectedGoalTime: String
    
    @Published
    var selectedAppHour: String
    
    @Published
    var selectedAppMinute: String
    
    var averageUseTime: String
    
    var period: Int
    
    var isChallengeMode: Bool
    
    var goalTime: Int
    
    var appGoalTime: Int
    
    @AppStorage("socialPlatform") private var socialPlatform = ""
    @AppStorage("userName") private var userName = ""
    
    @MainActor func saveOnboardingData() {
        print(onboardingState)
        switch onboardingState {
        case .timeSurveySelect:
            for index in 0..<4{
                if surveyButtonItems[onboardingState.rawValue][index].isSelected {
                    self.averageUseTime = surveyButtonItems[onboardingState.rawValue][index].buttonTitle
                }
            }
            addOnboardingState()
            offIsCompleted()
        case .problemSurveySelect:
            for index in 0..<4{
                if surveyButtonItems[onboardingState.rawValue][index].isSelected {
                    self.problems.append(surveyButtonItems[onboardingState.rawValue][index].buttonTitle)
                }
            }
            addOnboardingState()
            offIsCompleted()
        case .periodSelect:
            for index in 0..<4{
                if surveyButtonItems[onboardingState.rawValue] [index].isSelected {
                    self.period = removeLastCharacterAndConvertToInt(from: surveyButtonItems[onboardingState.rawValue] [index].buttonTitle) ?? 0
                    
                    print(surveyButtonItems[onboardingState.rawValue] [index].buttonTitle)
                    
                }
            }
            if isChallengeMode {
                onboardingState = .appGoalTimeSelect
            } else {
                addOnboardingState()
                offIsCompleted()
            }
        case .appGoalTimeSelect:
            self.appGoalTime = convertToTotalMilliseconds(hour: selectedAppHour, minute: selectedAppMinute)
            if isChallengeMode {
                screenViewModel.handleStartDeviceActivityMonitoring(interval: appGoalTime)
                postCreateChallengeData()
                isCompletePresented = true
            } else {
                addOnboardingState()
            }
        case .permissionSelect:
            screenViewModel.requestAuthorization()
            if screenViewModel.authorizationCenter.authorizationStatus == .approved {
                postSignUpLoginData()
            }
        default:
            break
        }
    }
    
    func alertAction() {
        postCreateChallengeData()
        addOnboardingState()
        isCompletePresented = false
    }
    
    func addOnboardingState() {
        onboardingState = OnboardingState(rawValue: onboardingState.rawValue + 1) ?? .timeSurveySelect
    }
    
    func backButtonTapped() {
        switch onboardingState {
        case .timeSurveySelect:
            UserManager.shared.appStateString = "login"
            offIsCompleted()
        case .problemSurveySelect, .periodSelect, .permissionSelect :
            onboardingState = OnboardingState(rawValue: onboardingState.rawValue - 1) ?? .timeSurveySelect
            offIsCompleted()
            resetAllSelections()
        default:
            onIsCompleted()
            onboardingState = OnboardingState(rawValue: onboardingState.rawValue - 1) ?? .timeSurveySelect
        }
    }
    
    func onIsCompleted() {
        isCompleted = true
    }
    
    func offIsCompleted() {
        isCompleted = false
    }
    
    func resetOnboardingState() {
        onboardingState = .timeSurveySelect
    }
    
    func getSurveyState() -> Int {
        return onboardingState.rawValue <= 2 ? onboardingState.rawValue : 0
    }
    
    func pushToComplete() {
        //        if onboardingState == 6 {
        //            NavigationLink(PermissionView)
        //        }
    }
    
    func removeLastCharacterAndConvertToInt(from string: String) -> Int? {
        guard !string.isEmpty else {
            return nil
        }
        
        let modifiedString = String(string.dropLast())
        
        return Int(modifiedString)
    }
    
    
    @MainActor func postSignUpLoginData() {
        let appValues = [ Apps(appCode: "app goalTime", goalTime: 3600000) ]
        // goalTime 1시간으로 하드 코딩
        let request = SignUpRequestDTO(socialPlatform: socialPlatform, name: userName, onboarding: Onboarding(averageUseTime: self.averageUseTime, problem: self.problems), challenge: Challenge(period: self.period, goalTime: self.appGoalTime, apps: appValues))
        
        let provider = Providers.AuthProvider
        provider.request(target: .signUp(data: request), instance: BaseResponse<SignUpResponseDTO>.self) { data in
            print(data.status)
            if data.status == 201 {
                UserManager.shared.appStateString = "onboardingComplete"
                UserManager.shared.isFirstLogin = true
                UserManager.shared.accessToken = data.data?.token.accessToken ?? ""
                UserManager.shared.refreshToken = data.data?.token.refreshToken ?? ""
            } else if data.message == "이미 회원가입된 유저입니다." {
                self.isOnboardingError = true
            } else {
                self.isOnboardingError = true
            }
        }
    }
    
    func postCreateChallengeData() {
        let request = CreateChallengeRequestDTO(period: self.period, goalTime: self.appGoalTime)
        
        let provider = Providers.challengeProvider
        provider.request(target: .createChallenge(data: request), instance: BaseResponse<EmptyResponseDTO>.self) { data in
            print(data.status)
        }
    }
    
    func patchApp(appGoalTime: Int) {
        let applist = [Apps(appCode: "#temp", goalTime: appGoalTime)]
        let requestDTO = AddAppRequestDTO(apps: applist)
        Providers.challengeProvider.request(target: .addApp(data: requestDTO),
                                            instance: BaseResponse<AddAppResponseDTO>.self) { result in
            print("result: \(result)")
        }
    }
    
    @MainActor func createAppChallengeData(appGoalTime: Int) {
        var applist: [Apps] = []
        //        screenViewModel.hashVaule
        applist = [Apps(appCode: "#24333", goalTime: appGoalTime)]
        Providers.challengeProvider.request(target: .addApp(data: AddAppRequestDTO(apps: applist)), instance: BaseResponse<EmptyResponseDTO>.self) { [weak self] result in
            UserManager.shared.appStateString = "home"
            self?.screenViewModel.handleStartDeviceActivityMonitoring(includeUsageThreshold: true, interval: self?.appGoalTime ?? 0)
        }
    }
    
    func changeSurveyButtonStatus(num: Int) {
        if onboardingState == .problemSurveySelect {
            let selectedCount = surveyButtonItems[onboardingState.rawValue].filter { $0.isSelected }.count
            if surveyButtonItems[onboardingState.rawValue][num].isSelected {
                surveyButtonItems[onboardingState.rawValue][num].isSelected.toggle()
            } else if selectedCount < 2 {
                surveyButtonItems[onboardingState.rawValue][num].isSelected = true
            }
        } else {
            for index in 0..<4 {
                surveyButtonItems[onboardingState.rawValue][index].isSelected = (index == num)
            }
        }
    }
    
    
    func convertToTotalMilliseconds(hour: String?, minute: String?) -> Int {
        let hourInt = Int(hour ?? "") ?? 0
        let minuteInt = Int(minute ?? "") ?? 0
        
        let totalMinutes = hourInt * 60 + minuteInt
        let totalMilliseconds = totalMinutes * 60 * 1000
        return totalMilliseconds
    }
    
    
    func getOnboardigMain() -> String {
        switch onboardingState {
        case .timeSurveySelect:
            StringLiteral.OnboardigMain.timeSurveySelect
        case .problemSurveySelect:
            StringLiteral.OnboardigMain.problemSurveySelect
        case .periodSelect:
            StringLiteral.OnboardigMain.periodSelect
        case .appGoalTimeSelect:
            StringLiteral.OnboardigMain.appGoalTimeSelect
        case .permissionSelect:
            StringLiteral.OnboardigMain.permissionSelect
        case .appSelect:
            StringLiteral.OnboardigMain.appSelect
        default:
            ""
        }
    }
    
    func getOnboardigSub() -> String {
        switch onboardingState {
        case .timeSurveySelect:
            ""
        case .problemSurveySelect:
            StringLiteral.OnboardigSub.problemSurveySelect
        case .periodSelect:
            StringLiteral.OnboardigSub.periodSelect
        case .appGoalTimeSelect:
            StringLiteral.OnboardigSub.appGoalTimeSelect
        case .permissionSelect:
            StringLiteral.OnboardigSub.permissionSelect
        case .appSelect:
            StringLiteral.OnboardigSub.appSelect
        default:
            ""
        }
    }
    
    func getNextButton() -> String {
        switch onboardingState {
        case .timeSurveySelect, .problemSurveySelect, .periodSelect, .appGoalTimeSelect:
            StringLiteral.OnboardingButton.next
        case .permissionSelect:
            StringLiteral.OnboardingButton.permission
        default:
            ""
        }
    }
    
    func handleOnAppear() {
        if onboardingState == .permissionSelect && isChallengeMode {
            isPickerPresented = true
        }
    }
    
    func resetAllSelections() {
        for i in 0..<surveyButtonItems.count {
            for j in 0..<surveyButtonItems[i].count {
                surveyButtonItems[i][j].isSelected = false
            }
        }
    }
    
    init(viewModel: ScreenTimeViewModel, onboardingState: OnboardingState = .timeSurveySelect, isChallengeMode: Bool = false) {
        self.surveyButtonItems = [
            [
                SurveyButtonInfo(buttonTitle: StringLiteral.TimeSurveySelect.firstSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.TimeSurveySelect.secondSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.TimeSurveySelect.thirdSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.TimeSurveySelect.fourthSelect, isSelected: false),
            ],
            [
                SurveyButtonInfo(buttonTitle: StringLiteral.ProblemSurveySelect.firstSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.ProblemSurveySelect.secondSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.ProblemSurveySelect.thirdSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.ProblemSurveySelect.fourthSelect, isSelected: false),
            ],
            [
                SurveyButtonInfo(buttonTitle: StringLiteral.PeriodSelect.firstSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.PeriodSelect.secondSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.PeriodSelect.thirdSelect, isSelected: false),
                SurveyButtonInfo(buttonTitle: StringLiteral.PeriodSelect.fourthSelect, isSelected: false),
            ]
        ]
        self.onboardingState = onboardingState
        self.isCompleted = false
        self.selectedGoalTime = "1"
        self.selectedAppHour = "0"
        self.selectedAppMinute = "0"
        self.problems = []
        self.averageUseTime = ""
        self.period = 0
        self.goalTime = 0
        self.appGoalTime = 0
        self.screenViewModel = viewModel
        self.isChallengeMode = isChallengeMode
    }
}
