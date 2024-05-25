//
//  ShieldConfigurationExtension.swift
//  ShieldConfigureExtension
//
//  Created by 이지희 on 5/25/24.
//
import SwiftUI
import UIKit

import ManagedSettings
import ManagedSettingsUI

// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    
    private func setShieldConfig(_ tokenName: String) -> ShieldConfiguration {
            let CUSTOM_ICON = UIImage(systemName: "heart")
            let CUSTOM_TITLE = ShieldConfiguration.Label(
                text: "목표 사용 시간 종료",
                color: .whiteText
            )
            let CUSTOM_SUBTITLE = ShieldConfiguration.Label(
                text: "이제 \(tokenName)을(를)\n 사용할 수 없어요",
                color: .gray2
            )
            let CUSTOM_PRIMARY_BUTTON_LABEL = ShieldConfiguration.Label(
                text: "닫기",
                color: .whiteText
            )
            let CUSTOM_PRIAMRY_BUTTON_BACKGROUND: UIColor = .bluePurpleButton
            let CUSTOM_SECONDARY_BUTTON_LABEL = ShieldConfiguration.Label(
                text: "잠금 해제하기",
                color: .gray1
            )
            
            let backgrounColor = UIColor(hue: 240/360, saturation: 14/100, brightness: 10/100, alpha: 1.0)
            
            let TWO_BUTTON_SHIELD_CONFIG = ShieldConfiguration(
                backgroundBlurStyle: .dark,
                backgroundColor: backgrounColor,
                icon: CUSTOM_ICON,
                title: CUSTOM_TITLE,
                subtitle: CUSTOM_SUBTITLE,
                primaryButtonLabel: CUSTOM_PRIMARY_BUTTON_LABEL,
                primaryButtonBackgroundColor: CUSTOM_PRIAMRY_BUTTON_BACKGROUND,
                secondaryButtonLabel: CUSTOM_SECONDARY_BUTTON_LABEL
            )
            
            return TWO_BUTTON_SHIELD_CONFIG
        }
    // MARK: - 어플리케이션만 제한된 앱
       override func configuration(shielding application: Application) -> ShieldConfiguration {
           // Customize the shield as needed for applications.
           guard let displayName = application.localizedDisplayName else {
               return setShieldConfig("확인불가 앱")
           }
           
           return setShieldConfig(displayName)
       }
       
       // MARK: - 카테고리를 통해 어플리케이션이 제한된 앱
       override func configuration(
           shielding application: Application,
           in category: ActivityCategory) -> ShieldConfiguration {
               // Customize the shield as needed for applications shielded because of their category.
               guard let displayName = application.localizedDisplayName,
                     let categoryName = category.localizedDisplayName else {
                   return setShieldConfig("확인불가 앱")
               }
               return setShieldConfig(categoryName + " " + displayName)
           }
       
       // MARK: - 웹 도메인만 제한된 앱
       override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
           // Customize the shield as needed for web domains.
           guard let displayName = webDomain.domain else {
               return setShieldConfig("확인불가 웹 도메인")
           }
           return setShieldConfig(displayName)
       }
       
       // MARK: - 카테고리를 통해 웹 도메인이 제한된 앱
       override func configuration(
           shielding webDomain: WebDomain,
           in category: ActivityCategory) -> ShieldConfiguration {
               // Customize the shield as needed for web domains shielded because of their category.
               guard let displayName = webDomain.domain,
                     let categoryName = category.localizedDisplayName else {
                   return setShieldConfig("확인불가 웹 도메인")
               }
               return setShieldConfig(categoryName + " " + displayName)
           }
}
