//
//  GuideView.swift
//  HMH_iOS
//
//  Created by 이지희 on 7/31/24.
//

import SwiftUI

struct GuideView: View {
    @Binding var isPresented: Bool
    @State private var currentIndex: Int = 0
    private typealias GuideTitle = StringLiteral.GuideTitle
    private let images = ["guideImg1", "guideImg2", "guideImg3"]
    private let titles = [GuideTitle.first, GuideTitle.second, GuideTitle.third]
    
    var body: some View {
        ZStack {
            Color(.black.withAlphaComponent(0.3))
                .ignoresSafeArea()
            VStack {
                Image(images[currentIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.horizontal, 22)
                    .padding(.top, 36)
                Text(titles[currentIndex])
                    .multilineTextAlignment(.center)
                    .padding(.top, 15)
                    .font(.text5_medium_16)
                    .foregroundStyle(.whiteText)
                Button(action: {
                    if currentIndex < images.count - 1 {
                        currentIndex += 1
                    } else {
                        isPresented = false
                    }
                }) {
                    Text(currentIndex < images.count - 1 ? "다음" : "확인")
                        .padding(.horizontal, 40)
                        .padding(.vertical, 14)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 90)
                .padding(.bottom, 22)
            }
            .frame(width: 300, height: 397)
            .background(.gray7)
            .cornerRadius(10)
            .shadow(radius: 10)
            .transition(.scale)
        }
        .onAppear {
            currentIndex = 0
        }
    }
}
