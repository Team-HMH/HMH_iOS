//
//  PointView.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/12/24.
//

import SwiftUI

struct PointView: View {
    @State var viewModel = PointViewModel()
    
    public init(viewModel: PointViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        main
            .onAppear {
                viewModel.getPointList()
            }
    }
}

extension PointView {
    private var main: some View {
        ScrollView {
            listView
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
        }
        .customNavigationBar(title: StringLiteral.NavigationBar.point,
                             showBackButton: true,
                             showPointButton: true,
                             isPointView: true, point: viewModel.currentPoint)
        .background(.blackground)
        .navigationBarHidden(true) 
    }
    
    private var listView: some View {
        ForEach(1...viewModel.challengeDay, id: \.self) { day in
            HStack {
                VStack(alignment: .leading) {
                    Text("\(day)" + StringLiteral.Challenge.pointTitle)
                        .font(.text4_semibold_16)
                        .foregroundColor(.whiteText)
                        .padding(.bottom, 2)
                    Text("\(viewModel.challengeDay)" + StringLiteral.Challenge.pointSubTitle)
                        .font(.detail4_medium_12)
                        .foregroundColor(.gray2)
                }
                Spacer()
                EarnPointButton(day: day, viewModel: viewModel)
            }
            .frame(height: 80)
        }
    }
}

#Preview {
    PointView(viewModel: .init())
}

struct EarnPointButton: View {
    let day: Int
    @ObservedObject var viewModel: PointViewModel
    
    var body: some View {
        Button(action: {
            viewModel.patchPointUse(day: day)
        }, label: {
            Text(StringLiteral.Challenge.pointButton)
                .font(.text4_semibold_16)
                .foregroundStyle(.whiteBtn)
                .frame(width: 73, height: 40)
                .background(.bluePurpleButton)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 3, height: 3)))
        })
    }
}

