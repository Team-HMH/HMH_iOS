//
//  CustomAlertModifier.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/13/24.
//


import SwiftUI

enum CustoAlertButtonType {
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
    
    var cancelWidth: CGFloat {
        switch self {
        case .unlock:
            160
        case .unlockComplete:
            0
        case .insufficientPoints:
            160
        case .usePoints:
            236
        case .withdraw:
            129
        case .challengeCreationComplete:
            238
        case .logout:
            129
        }
    }
    
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
    
    var image: UIImage {
        switch self {
        case .unlock:
                .challengeWarn
        case .unlockComplete:
                .challengeFail
        case .insufficientPoints:
                .point
        case .usePoints:
                .lock
        case .challengeCreationComplete:
                .challengeCreate
        default:
                .challengeFail
        }
    }
    
    var title: String {
        switch self {
        case .unlock:
            StringLiteral.AlertTitle.unlock
        case .unlockComplete:
            StringLiteral.AlertTitle.unlockComplete
        case .insufficientPoints:
            StringLiteral.AlertTitle.insufficientPoints
        case .usePoints:
            StringLiteral.AlertTitle.usePoints
        case .withdraw:
            StringLiteral.AlertTitle.withdraw
        case .challengeCreationComplete:
            StringLiteral.AlertTitle.challengeCreationComplete
        case .logout:
            StringLiteral.AlertTitle.logout
        }
    }
    
    var subTitle: String {
        switch self {
        case .unlock:
            StringLiteral.AlertDescription.unlock
        case .unlockComplete:
            StringLiteral.AlertDescription.unlock
        case .insufficientPoints:
            StringLiteral.AlertDescription.insufficientPoints
        case .withdraw:
            StringLiteral.AlertDescription.withdraw
        case .challengeCreationComplete:
            StringLiteral.AlertDescription.challengeCreationComplete
        default:
            ""
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
    
    let alert: CustomAlertView
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresent) {
                alert
            }
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
    }
}

struct CustomAlertButtonView: View {
    
    typealias Action = () -> ()
    @Binding var isPresented: Bool
    
    var action: Action
    var buttonType : CustoAlertButtonType
    var alertType : CustomAlertType
    
    private var buttonBackgroundColor: Color {
        switch (buttonType, alertType) {
        case (.Confirm, _):
            return .clear
        case (.Cancel, .logout), (.Cancel, .withdraw):
            return .gray2
        case (.Cancel, _):
            return .bluePurpleButton
        }
    }
    
    init(buttonType: CustoAlertButtonType,
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
            isPresented = false
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
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.1)
                .ignoresSafeArea()
            
            VStack(spacing: .zero) {
                Spacer()
                    .frame(height: 36)
                VStack(spacing: 14) {
                    if alertType == .challengeCreationComplete {
                        Image(uiImage: alertType.image)
                            .resizable()
                            .frame(width: 120, height: 120)
                    }
                    Text(alertType.title)
                        .foregroundColor(.whiteText)
                        .font(.text3_semibold_18)
                        .multilineTextAlignment(.center)
                    Text(alertType.subTitle)
                        .foregroundColor(.gray1)
                        .font(.text6_medium_14)
                        .multilineTextAlignment(.center)
                    Image(uiImage: alertType.image)
                        .resizable()
                        .frame(width: 120, height: 120)
                    if alertType == .unlockComplete || alertType == .usePoints {
                        HStack() {
                            Text("보유 포인트")
                                .font(.text5_medium_16)
                                .foregroundColor(.gray1)
                            Text("00P")
                                .font(.text5_medium_16)
                                .foregroundColor(.whiteText)
                        }
                    }
                }
                Spacer()
                HStack(spacing: 8) {
                    confirmBtn
                    cancelBtn
                        .frame(width: alertType.cancelWidth)
                }
                .frame(width:266, height: 52)
                Spacer()
                    .frame(height: 22)
            }
            .frame(width: 310, height: alertType.frameHeight)
            .background(.gray7)
            .cornerRadius(10)
        }
        .background(ClearBackground())
    }
}


extension View {
    func customAlert(isPresented:Binding<Bool>, customAlert: @escaping () -> CustomAlertView) -> some View {
        return modifier(CustomAlertModifier(isPresent: isPresented, alert: customAlert()))
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

