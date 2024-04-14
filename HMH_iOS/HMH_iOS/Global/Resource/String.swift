//
//  String.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import Foundation

enum StringLiteral {
    enum TabBar {
        static var challengeTitle = "챌린지"
        static var homeTitle = "홈"
        static var myPageTitle = "마이페이지"
    }
    
    enum Home {
        static let usageStatusA = "별조각을 잘 따라가고 있어요\n오늘도 화이팅!"
        static let usageStatusB = "별조각이 살짝 멀어졌어요\n조금 더 힘을 내요!"
        static let usageStatusC = "이런, 별조각이 희미해요\n방향을 잃지 않게 조심하세요"
        static let usageStatusD = "블랙홀이 더 가까워졌어요.\n유혹을 이겨내세요!"
        static let usageStatusE = "블랙홀이 눈앞에 있어요!\n지금 더 사용하면 실패해요."
        static let goalTime = "목표 사용 시간"
        static let use = "사용"
        static let leftTime = "남음"
    }
    
    enum Challenge {
        
    }
    
    enum myPage {
        
    }
    
    enum AlertButton {
        
    }
    
    enum AlertTitle {
        
    }
    
    enum AlertDescription {
        
    }
    
    enum OnboardingButton {
        static var next = "다음"
        static var permission = "권한 허용하러 가기"
        static var appSelect = "앱 선택하기"
        static var complete = "완료"
        static var story = "탈출 스토리 보기"
    }
    
    enum OnboardigMain {
        static var timeSurveySelect = "하루 평균 휴대폰을\n얼마나 사용하나요?"
        static var problemSurveySelect = "휴대폰으로 인해\n어떤 문제를 겪고 있나요?"
        static var periodSelect = "챌린지 기간을 선택해 주세요"
        static var goalTimeSelect = "총 목표 사용 시간을\n설정해 주세요"
        static var permissionSelect = "스크린타임과 푸시 알림\n권한 허용이 필요해요"
        static var appSelect = "중독에서 탈출하고 싶은\n앱을 선택해 주세요"
        static var appGoalTimeSelect = "선택한 앱의 목표 사용 시간을\n설정해 주세요"
    }
    
    enum OnboardigSub {
        static var problemSurveySelect = "해당 문항은 최대 2개까지 선택할 수 있어요"
        static var periodSelect = "첫 챌린지로 가볍게 도전하기 좋은 7일을 추천해요"
        static var goalTimeSelect = "목표 사용 시간은 최대 6시간까지 설정할 수 있어요"
        static var permissionSelect = "언제든지 설정에서 스크린타임과\n푸시 알림 권한을 변경할 수 있어요"
        static var appSelect = "목표 사용 시간이 지나면 앱이 잠겨요\n선택하고 싶은 앱은 언제든지 추가할 수 있어요"
        static var appGoalTimeSelect = "목표 사용 시간은 최대 1시간 59분까지\n설정할 수 있어요"
    }
    
    enum TimeSurveySelect {
        static var firstSelect = "1-4시간"
        static var secondSelect = "4-8시간"
        static var thirdSelect = "8-12시간"
        static var fourthSelect = "12시간 이상"
    }
    
    enum ProblemSurveySelect {
        static var firstSelect = "일상생활에 영향을 끼쳐요"
        static var secondSelect = "이용 시간이 스스로 제어되지 않아요"
        static var thirdSelect = "특정 앱에 수시로 접속하게 돼요"
        static var fourthSelect = "중독을 탈출하려고 노력해도 잘 안 돼요"
    }
    
    enum PeriodSelect {
        static var firstSelect = "7일"
        static var secondSelect = "14일"
        static var thirdSelect = "20일"
        static var fourthSelect = "30일"
    }
}
