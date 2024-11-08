//
//  SwipeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 5/4/24.
//

import SwiftUI

import DSKit

struct SwipeView: View {
    var swipeImages: [Image]
    private let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    @State private var selectedImageIndex: Int = 0
    
    var body: some View {
        VStack {
            TabView(selection: $selectedImageIndex) {
                ForEach(0..<swipeImages.count, id: \.self) { index in
                    swipeImages[index]
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .tag(index)
                }
            }
            .padding(.bottom, 30)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            HStack {
                ForEach(0..<swipeImages.count, id: \.self) { index in
                    Rectangle()
                        .fill(selectedImageIndex == index ? Color(.white) : Color(DSKitAsset.gray2.swiftUIColor))
                        .frame(width: 8, height: 8)
                        .onTapGesture {
                            selectedImageIndex = index
                        }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .onReceive(timer) { _ in
            withAnimation(.default) {
                selectedImageIndex = (selectedImageIndex + 1) % swipeImages.count
            }
        }
    }
}
