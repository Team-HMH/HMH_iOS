//
//  CustomAlertModifier.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/13/24.
//

import SwiftUI

enum CustomAlertButtonType {
    case Confirm
    case Cancel
}

enum CustomAlertType {
    case unlock
    case unlockComplete
    case insufficientPoints
    case usePoints
    case withdraw
    case challengeCreationComplete
    case logout
    
    var frameHeight: CGFloat {
        switch self {
        case .unlock:
            320
        case .unlockComplete:
            382
        case .insufficientPoints:
            320
        case .usePoints:
            350
        case .withdraw:
            220
        case .challengeCreationComplete:
            340
        case .logout:
            190
        }
    }
        
    var confirmButtonText: String {
        switch self {
        case .unlock:
            StringLiteral.AlertConfirmButton.unlock
        case .unlockComplete:
            StringLiteral.AlertConfirmButton.unlockComplete
        case .insufficientPoints:
            StringLiteral.AlertConfirmButton.insufficientPoints
        case .withdraw:
            StringLiteral.AlertConfirmButton.withdraw
        case .logout:
            StringLiteral.AlertConfirmButton.logout
        default:
            ""
        }
    }
    
    var cancelButtonText: String {
        switch self {
        case .unlock:
            StringLiteral.AlertCancelButton.unlock
        case .unlockComplete:
            StringLiteral.AlertCancelButton.unlockComplete
        case .insufficientPoints:
            StringLiteral.AlertCancelButton.insufficientPoints
        case .withdraw:
            StringLiteral.AlertCancelButton.withdraw
        case .usePoints:
            StringLiteral.AlertCancelButton.usePoints
        case .logout:
            StringLiteral.AlertCancelButton.logout
        case .challengeCreationComplete:
            StringLiteral.AlertCancelButton.challengeCreationComplete
        default:
            ""
        }
    }
}

struct CustomAlertModifier: ViewModifier {
    
    @Binding var isPresent: Bool
    let alert: () -> CustomAlertView
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    if isPresent {
                        alert()
                    }
                }
            )
    }
}

struct CustomAlertButtonView: View {
    
    typealias Action = () -> Void
    @Binding var isPresented: Bool
    
    var action: Action
    var buttonType: CustomAlertButtonType
    var alertType: CustomAlertType
    
    private var buttonBackgroundColor: Color {
        switch (buttonType, alertType) {
        case (.Confirm, _):
            return .clear
        case (.Confirm, .logout), (.Confirm, .withdraw):
            return .gray6
        case (.Cancel, _):
            return .bluePurpleButton
        }
    }
    
    init(buttonType: CustomAlertButtonType,
         alertType: CustomAlertType,
         isPresented: Binding<Bool>,
         action: @escaping Action) {
        self._isPresented = isPresented
        self.action = action
        self.buttonType = buttonType
        self.alertType = alertType
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(buttonType == .Confirm ? alertType.confirmButtonText : alertType.cancelButtonText)
                .foregroundColor(.whiteBtn)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(buttonBackgroundColor)
        .cornerRadius(8)
    }
}


struct CustomAlertView: View {
    let alertType: CustomAlertType
    let confirmBtn: CustomAlertButtonView
    let cancelBtn: CustomAlertButtonView
    @Binding var currentPoint: Int?
    
    
    init(alertType: CustomAlertType, confirmBtn: CustomAlertButtonView, cancelBtn: CustomAlertButtonView, currentPoint: Binding<Int?>) {
        self.alertType = alertType
        self.confirmBtn = confirmBtn
        self.cancelBtn = cancelBtn
        self._currentPoint = currentPoint
    }
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.1)
                .ignoresSafeArea()
            
            VStack(spacing: .zero) {
                alertView
            }
            .frame(width: 310, height: alertType.frameHeight)
            .background(.gray7)
            .cornerRadius(10)
        }
        .background(ClearBackground())
    }
    
    private var alertView: some View {
        Group {
            switch alertType {
            case .unlock:
                UnlockAlertView(confirmBtn: confirmBtn, cancelBtn: cancelBtn)
            case .unlockComplete:
                UnlockCompleteAlertView(confirmBtn: confirmBtn, currentPoint: $currentPoint)
            case .insufficientPoints:
                InsufficientPointsAlertView(confirmBtn: confirmBtn, cancelBtn: cancelBtn)
            case .usePoints:
                UsePointsAlertView(confirmBtn: confirmBtn, cancelBtn: cancelBtn, currentPoint: $currentPoint)
            case .withdraw:
                WithdrawAlertView(confirmBtn: confirmBtn, cancelBtn: cancelBtn)
            case .challengeCreationComplete:
                ChallengeCreationCompleteAlertView(cancelBtn: cancelBtn)
            case .logout:
                LogoutAlertView(confirmBtn: confirmBtn, cancelBtn: cancelBtn)
            }
        }
    }
}

extension View {
    func customAlert(isPresented: Binding<Bool>, customAlert: @escaping () -> CustomAlertView) -> some View {
        self.modifier(CustomAlertModifier(isPresent: isPresented, alert: customAlert))
    }
}

struct ClearBackground: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = ClearBackgroundView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

open class ClearBackgroundView: UIView {
    open override func layoutSubviews() {
        guard let parentView = superview?.superview else {
            print("ERROR: Failed to get parent view to make it clear")
            return
        }
        parentView.backgroundColor = .clear
    }
}
