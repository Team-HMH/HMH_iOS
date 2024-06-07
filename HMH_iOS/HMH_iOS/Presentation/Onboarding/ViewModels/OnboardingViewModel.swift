//
//  OnboardingViewModel.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI
import FamilyControls

class OnboardingViewModel: ObservableObject {
    
    var screenViewModel: ScreenTimeViewModel
    
    @Published
    var surveyButtonItems: [[SurveyButtonInfo]]
    
    var problems: [String]
    
    @Published
    var onboardingState: Int
    
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
        case 0:
            for index in 0..<4{
                if surveyButtonItems[onboardingState][index].isSelected {
                    self.averageUseTime = surveyButtonItems[onboardingState][index].buttonTitle
                }
            }
            addOnboardingState()
            offIsCompleted()
        case 1:
            for index in 0..<4{
                if surveyButtonItems[onboardingState] [index].isSelected {
                    self.problems.append(surveyButtonItems[onboardingState][index].buttonTitle)
                }
            }
            addOnboardingState()
            offIsCompleted()
        case 2:
            for index in 0..<4{
                if surveyButtonItems[onboardingState] [index].isSelected {
                    self.period = removeLastCharacterAndConvertToInt(from: surveyButtonItems[onboardingState] [index].buttonTitle) ?? 0
                    
                    print(surveyButtonItems[onboardingState] [index].buttonTitle)
                    
                }
            }
            addOnboardingState()
            offIsCompleted()
        case 3:
            self.goalTime = convertToTotalMilliseconds(hour: selectedGoalTime, minute: "0")
            if isChallengeMode {
                isCompletePresented = true
            } else {
                addOnboardingState()
            }
        case 4:
            screenViewModel.requestAuthorization()
            if screenViewModel.hasScreenTimePermission {
                onboardingState += 1
            }
        case 5:
            isPickerPresented = true
        case 6:
            self.appGoalTime = convertToTotalMilliseconds(hour: selectedAppHour, minute: selectedAppMinute)
            if isChallengeMode {
                createAppChallengeData()
                addOnboardingState()
            } else {
                postSignUpLoginData()
            }
            offIsCompleted()
        default:
            break
        }
    }
    
    func alertAction() {
        postCreateChallengeData()
        addOnboardingState()
    }
    
    func addOnboardingState() {
        onboardingState += 1
    }
    
    func backButtonTapped() {
        if onboardingState == 0 {
            UserManager.shared.appStateString = "login"
        } else {
            onboardingState -= 1
        }
    }
    
    func onIsCompleted() {
        isCompleted = true
    }
    
    func offIsCompleted() {
        isCompleted = false
    }
    
    func resetOnboardingState() {
        onboardingState = 0
    }
    
    func getSurveyState() -> Int {
        return onboardingState <= 2 ? onboardingState : 0
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
        let appValues = screenViewModel.hashVaule.map { Apps(appCode: "\($0)", goalTime: appGoalTime) }
        let request = SignUpRequestDTO(socialPlatform: socialPlatform, name: userName, onboarding: Onboarding(averageUseTime: self.averageUseTime, problem: self.problems), challenge: Challenge(period: self.period, goalTime: self.goalTime, apps: appValues))
        
        let provider = Providers.AuthProvider
        provider.request(target: .signUp(data: request), instance: BaseResponse<SignUpResponseDTO>.self) { data in
            print(data.status)
            if data.status == 201 {
                UserManager.shared.appStateString = "onboardingComplete"
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
        let request = CreateChallengeRequestDTO(period: self.period, goalTime: self.goalTime)
        
        let provider = Providers.challengeProvider
        provider.request(target: .createChallenge(data: request), instance: BaseResponse<EmptyResponseDTO>.self) { data in
            print(data.status)
        }
    }
    
    @MainActor func createAppChallengeData() {
        var applist: [Apps] = []
        //        screenViewModel.hashVaule
        applist = [Apps(appCode: "#24333", goalTime: self.goalTime)]
        Providers.challengeProvider.request(target: .addApp(data: AddAppRequestDTO(apps: applist)), instance: BaseResponse<EmptyResponseDTO>.self) { [weak self] result in
            UserManager.shared.appStateString = "home"
            self?.screenViewModel.handleStartDeviceActivityMonitoring(includeUsageThreshold: true, interval: self?.appGoalTime ?? 0)
        }
    }
    
    func changeSurveyButtonStatus(num: Int) {
        if onboardingState == 1 {
            surveyButtonItems[onboardingState][num].isSelected.toggle()
        } else {
            for index in 0..<4 {
                surveyButtonItems[onboardingState][index].isSelected = (index == num)
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
        case 0:
            StringLiteral.OnboardigMain.timeSurveySelect
        case 1:
            StringLiteral.OnboardigMain.problemSurveySelect
        case 2:
            StringLiteral.OnboardigMain.periodSelect
        case 3:
            StringLiteral.OnboardigMain.goalTimeSelect
        case 4:
            StringLiteral.OnboardigMain.permissionSelect
        case 5:
            StringLiteral.OnboardigMain.appSelect
        case 6:
            StringLiteral.OnboardigMain.appGoalTimeSelect
        default:
            ""
        }
    }
    
    func getOnboardigSub() -> String {
        switch onboardingState {
        case 0:
            ""
        case 1:
            StringLiteral.OnboardigSub.problemSurveySelect
        case 2:
            StringLiteral.OnboardigSub.periodSelect
        case 3:
            StringLiteral.OnboardigSub.goalTimeSelect
        case 4:
            StringLiteral.OnboardigSub.permissionSelect
        case 5:
            StringLiteral.OnboardigSub.appSelect
        case 6:
            StringLiteral.OnboardigSub.appGoalTimeSelect
        default:
            ""
        }
    }
    
    func getNextButton() -> String {
        switch onboardingState {
        case 0, 1, 2, 3:
            StringLiteral.OnboardingButton.next
        case 4:
            StringLiteral.OnboardingButton.permission
        case 5:
            StringLiteral.OnboardingButton.appSelect
        case 6:
            StringLiteral.OnboardingButton.complete
        default:
            ""
        }
    }
    
    func handleOnAppear() {
        if onboardingState == 4 && isChallengeMode {
            isPickerPresented = true
        }
    }
    
    init(viewModel: ScreenTimeViewModel, onboardingState: Int = 0, isChallengeMode: Bool = false) {
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
        self.selectedGoalTime = ""
        self.selectedAppHour = ""
        self.selectedAppMinute = ""
        self.problems = []
        self.averageUseTime = ""
        self.period = 0
        self.goalTime = 0
        self.appGoalTime = 0
        self.screenViewModel = viewModel
        self.isChallengeMode = isChallengeMode
    }
}
