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
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            TabView(selection: Binding(
                get: { viewModel.state.swipeImageIndex },
                set: { index in
                    viewModel.send(action: .setSwipeIndex(index: index))
                }
            )) {
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
                        .fill(viewModel.state.swipeImageIndex == index ? Color(.white) : Color(DSKitAsset.gray2.swiftUIColor))
                        .frame(width: 8, height: 8)
                        .onTapGesture {                                viewModel.send(action: .setSwipeIndex(index: index))
                        }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
