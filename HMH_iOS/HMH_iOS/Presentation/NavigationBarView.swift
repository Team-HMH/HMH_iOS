//
//  NavigationView.swift
//  HMH_iOS
//
//  Created by 이지희 on 3/31/24.
//

import SwiftUI

struct NavigationBarView: View {
    @Environment(\.dismiss) var dismiss
    
    let showBackButton: Bool
    let showPointButton: Bool
    let isPointView: Bool
    let title: String
    let point = 100
    
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
        var titleView: some View {
            HStack{
                if showBackButton {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(.chevronLeft)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 20)
                    }
                    .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 8))
                } else {
                    Image(.chevronLeft).hidden()
                        .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 0))
                }
                Text(title).foregroundStyle(Color.gray1)
                    .font(.text3_semibold_18)
                    .frame(maxWidth: .infinity,
                           alignment: .center)
                if showPointButton {
                    Button(action: { }) {
                        Image(.navigationPoint)
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                } else {
                    Image(.navigationPoint).hidden()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                }
            }
        }
        return titleView
    }
    
    private func SecondaryTitleView() -> some View {
        var titleView: some View {
            HStack{
                Button(action: {
                    dismiss()
                }) {
                    Image(.chevronLeft)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20,height: 20)
                }
                .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 8))
                Text(title).foregroundStyle(Color.gray1)
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
        
        return titleView
    }
}

#Preview {
    NavigationBarView(showBackButton: false, showPointButton: true, isPointView: true, title: "마이페이지")
}
