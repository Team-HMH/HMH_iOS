//
//  OnboardingViewModel.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    
    @Published
    var surveyButtonItems: [[SurveyButtonInfo]]
    
    var problems: [String]
    
    @Published
    var onboardingState: Int
    
    @Published
    var isCompleted: Bool
    
    @Published
    var selectedGoalTime: String
    
    @Published
    var selectedAppHour: String
    
    @Published
    var selectedAppMinute: String
    
    var averageUseTime: String
    
    var period: Int
    
    var goalTime: Int
    
    var appGoalTime: Int
        
    
    @AppStorage("socialPlatform") private var socialPlatform = ""
    @AppStorage("userName") private var userName = ""
    
    func saveOnboardingData() {
        print(onboardingState)
        switch onboardingState {
        case 1:
            for index in 0..<4{
                if surveyButtonItems[onboardingState  - 1][index].isSelected {
                    self.averageUseTime = surveyButtonItems[onboardingState - 1][index].buttonTitle
                }
            }
        case 2:
            for index in 0..<4{
                if surveyButtonItems[onboardingState - 1][index].isSelected {
                    self.problems.append(surveyButtonItems[onboardingState - 1][index].buttonTitle)
                }
            }
        case 3:
            for index in 0..<4{
                if surveyButtonItems[onboardingState - 1][index].isSelected {
                    self.period = removeLastCharacterAndConvertToInt(from: surveyButtonItems[onboardingState - 1][index].buttonTitle) ?? 0

                    print(surveyButtonItems[onboardingState - 1][index].buttonTitle)
                    
                }
            }
        case 4:
            self.goalTime = convertToTotalMilliseconds(hour: selectedGoalTime, minute: "0")
        case 7:
            self.appGoalTime = convertToTotalMilliseconds(hour: selectedAppHour, minute: selectedAppMinute)
            postSignUpLoginData()
            
        default:
            break
        }
    }
    
    func addOnboardingState() {
        onboardingState += 1
    }
    
    func onIsCompleted() {
        isCompleted = true
    }
    
    func offIsCompleted() {
        if onboardingState != 4 && onboardingState != 5 {
            isCompleted = false
        }
        // 권한 허용 버튼 활성화를 위함
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

    
    func postSignUpLoginData() {
        let request = SignUpRequestDTO(socialPlatform: socialPlatform, name: userName, onboarding: Onboarding(averageUseTime: self.averageUseTime, problem: self.problems), challenge: Challenge(period: self.period, goalTime: self.goalTime, apps: [Apps(appCode: "#23324", goalTime: appGoalTime)]))
        
        let provider = Providers.AuthProvider
        provider.request(target: .signUp(data: request), instance: BaseResponse<SignUpResponseDTO>.self) { data in
            if data.status == 201 {
                UserManager.shared.isOnboardingCompleted = true
//                self.setRootViewController(SignInCompleteViewController())
//                guard let data = data.data else { return }
//                UserManager.shared.updateToken(data.token.accessToken, data.token.refreshToken)
//                UserManager.shared.updateUserId(data.userId)
            } else {
                self.onboardingState = 0
//                self.setRootViewController(LoginViewController())
            }
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
            "error"
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
            "error"
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
            "error"
        }
    }
    
    init() {
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
        self.onboardingState = 0
        self.isCompleted = false
        self.selectedGoalTime = ""
        self.selectedAppHour = ""
        self.selectedAppMinute = ""
        self.problems = []
        self.averageUseTime = ""
        self.period = 0
        self.goalTime = 0
        self.appGoalTime = 0
    }
}
