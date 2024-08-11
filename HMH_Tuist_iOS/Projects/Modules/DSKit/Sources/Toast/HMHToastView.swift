//
//  HMHToastView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/30/24.
//

import SwiftUI

public enum ToastType {
    case pointWarn
    case onboardingWarn
    case earnPoint
}

struct HMHToastView: View {
    var toastType: ToastType
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Spacer()
            toastContentView()
                .transition(.move(edge: .bottom))
                .frame(width: 328, height: 48)
                .background(DSKitAsset.toast.swiftUIColor)
                .cornerRadius(43)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
        }
        .padding(.bottom, 30)
    }
    
    @ViewBuilder
    private func toastContentView() -> some View {
        switch toastType {
        case .pointWarn:
            pointWarnView()
        case .onboardingWarn:
            onboardingWarnView()
        case .earnPoint:
            earnPointView()
        }
    }
    
    private func earnPointView() -> some View {
        HStack {
            Text("포인트를 획득했어요!")
                .foregroundColor(DSKitAsset.whiteBtn.swiftUIColor)
                .font(.text6_medium_14)
        }
    }
    
    private func onboardingWarnView() -> some View {
        HStack {
            Text("오류입니다.")
                .foregroundColor(DSKitAsset.whiteBtn.swiftUIColor)
                .font(.text6_medium_14)
        }
    }
    
    private func pointWarnView() -> some View {
        HStack {
            Text("포인트를 다 받은 후 챌린지를 생성하세요")
                .foregroundColor(DSKitAsset.whiteBtn.swiftUIColor)
                .font(.text6_medium_14)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            Spacer()
            //TODO: PointView를 여기에 넣는게 맞을까? 그 이후 행동에 대한 분기처리는 다른곳에서 일어나야된다!
//            NavigationLink(destination: PointView()) {
//                Text("이동")
//                    .font(.text4_semibold_16)
//                    .foregroundColor(DSKitAsset.bluePurpleText.swiftUIColor)
//            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
        }
    }
}

extension View {
    public func showToast(toastType: ToastType, isPresented: Binding<Bool>) -> some View {
        ZStack {
            self
            if isPresented.wrappedValue {
                VStack {
                    Spacer()
                    HMHToastView(toastType: toastType, isPresented: isPresented)
                        .padding(.bottom, 30)
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: isPresented.wrappedValue)
            }
        }
    }
}
