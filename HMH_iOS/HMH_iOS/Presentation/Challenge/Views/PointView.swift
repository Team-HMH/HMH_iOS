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
                             isPointView: true)
        .background(.blackground)
        .navigationBarHidden(true) 
    }
    
    private var listView: some View {
        ForEach(1...viewModel.challengeDay + 1, id: \.self) { day in
            HStack{
                VStack(alignment: .leading){
                    Text("\(day)" + StringLiteral.Challenge.pointTitle)
                        .font(.text4_semibold_16)
                        .foregroundStyle(.whiteText)
                        .padding(.bottom, 2)
                    Text("\(viewModel.challengeDay)" + StringLiteral.Challenge.pointSubTitle)
                        .font(.detail4_medium_12)
                        .foregroundStyle(.gray2)
                }
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text(StringLiteral.Challenge.pointButton)
                        .font(.text4_semibold_16)
                        .foregroundStyle(.whiteBtn)
                        .frame(width: 73, height: 40)
                        .background(.bluePurpleButton)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 3, height: 3)))
                })
            }
            .frame(height: 80)
        }
    }
}

#Preview {
    PointView(viewModel: .init())
}
