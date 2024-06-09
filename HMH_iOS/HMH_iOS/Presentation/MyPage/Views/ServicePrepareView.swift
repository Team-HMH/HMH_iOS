//
//  ServicePrepareView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 6/9/24.
//

import SwiftUI

struct ServicePrepareView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("서비스 준비 중입니다.")
                .font(.largeTitle)
                .padding()
            Text("현재 서비스 준비 중입니다. 나중에 다시 시도해 주세요.")
                .font(.body)
                .foregroundColor(.white)
                .padding()
            Button {
                if presentationMode.wrappedValue.isPresented {
                    dismiss()
                } else {
                    UserManager.shared.appStateString = "home"
                }
            } label: {
                Text("돌아가기")
                    .foregroundColor(.whiteBtn)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .cornerRadius(8)
        }
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}


