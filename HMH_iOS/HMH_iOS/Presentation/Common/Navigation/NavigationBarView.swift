//
//  NavigationView.swift
//  HMH_iOS
//
//  Created by 이지희 on 3/31/24.
//
import SwiftUI

struct NavigationBarView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showGuideView: Bool
    
    let showBackButton: Bool
    let showPointButton: Bool
    let showGuideButton: Bool
    let isPointView: Bool
    let title: String
    let point: Int
    
    var body: some View {
        ZStack {
            Color.blackground
                .ignoresSafeArea()
            if isPointView {
                SecondaryTitleView()
            } else {
                TitleView()
            }
        }
        .frame(height: 60)
    }
}

extension NavigationBarView {
    private func TitleView() -> some View {
        HStack {
            if showBackButton {
                Button(action: {
                    dismiss()
                }) {
                    Image(.chevronLeft)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 8))
            } else {
                Image(.chevronLeft).hidden()
                    .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 0))
            }
            Text(title)
                .foregroundStyle(Color.gray1)
                .font(.text3_semibold_18)
                .frame(maxWidth: .infinity, alignment: .center)
            if showGuideButton {
                Button(action: {
                    showGuideView.toggle()
                }) {
                    Image(.guidebtn1)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
            } else if showPointButton {
                NavigationLink(destination: PointView(viewModel: .init())) {
                    point == 0 ? Image(.navigationPoint) : Image(.remainEarnPoint)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
            } else {
                Image(.navigationPoint).hidden()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
            }
        }
    }
    
    private func SecondaryTitleView() -> some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(.chevronLeft)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 8))
            Text(title)
                .foregroundStyle(Color.gray1)
                .font(.text3_semibold_18)
            Spacer()
            if showPointButton {
                Label {
                    Text("\(point)p")
                        .font(.text4_semibold_16)
                        .foregroundColor(.whiteText)
                } icon : {
                    Image(.navigationPoint)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .padding(.trailing, 20)
            }
        }
    }
}

#Preview {
    NavigationBarView(showGuideView: .constant(false), showBackButton: false, showPointButton: true, showGuideButton: true, isPointView: false, title: "마이페이지", point: 100)
}
