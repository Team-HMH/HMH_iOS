//
//  PointServiceView.swift
//  NetworksDemo
//
//  Created by 류희재 on 11/22/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI
import Networks
import Core
import Combine

struct PointServiceView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: PointServiceViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.send(action: .backButtonDidTap)
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 12, height: 24)
                }
                .padding(.leading, 14)
                
                Spacer()
                
                Text("PointService")
                    .foregroundStyle(Color(
                        red: 165 / 255.0,
                        green: 165 / 255.0,
                        blue: 187 / 255.0
                    ))
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding(.vertical, 18)
            
            ServiceListView(viewModel: viewModel)
                .padding(.horizontal, 20)
                .padding(.bottom, 25)
                .frame(height: 360)
            
            Rectangle()
                .foregroundColor(.white)
                .frame(width: .infinity, height: 3)
                .padding(.horizontal, 20)
                .padding(.bottom, 25)
            
            Text(viewModel.state.networkLoggingText)
                .padding(.top, 25)
                .padding(.horizontal, 20)
                .frame(width: 335, height: 240)
                .background(.gray)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .setHMHNavigation()
        .background(Color(asset: NetworksDemoAsset.blackground))
    }
}

fileprivate struct ServiceListView: View {
    private let viewModel: PointServiceViewModel
    
    init(viewModel: PointServiceViewModel) {
        self.viewModel = viewModel
    }
    
    let apiList: [String] = [
        "PatchPointUse",
        "GetEarnPoint",
        "GetUsagePoint",
        "PatchEarnPoint",
        "GetPointList"
        
    ]
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 24)
            
            ScrollView(.vertical, showsIndicators: true) {
                ForEach(Array(apiList.enumerated()), id: \.element) { index, api in
                    ServiceCellView(apiTitle: api, index: index, viewModel: viewModel)
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: .infinity, height: 1)
                }
            }
        }
    }
}

fileprivate struct ServiceCellView: View {
    private let apiTitle: String
        private let index: Int
        @ObservedObject private var viewModel: PointServiceViewModel
        
        init(apiTitle: String, index: Int, viewModel: PointServiceViewModel) {
            self.apiTitle = apiTitle
            self.index = index
            self.viewModel = viewModel
        }
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(apiTitle)
                    .foregroundStyle(Color(
                        red: 219 / 255.0,
                        green: 218 / 255.0,
                        blue: 231 / 255.0
                    ))
                    .font(.title2)
                    .bold()
                    .frame(height: 2)
                    .padding(.bottom, 10)
                
                Text("테스트 결과: \(viewModel.state.resultText[index])")
                    .foregroundColor(.white)
                    .font(.body)
                    .bold()
            }
            .padding(.vertical, 18)
            
            Spacer()
            
            Button {
                viewModel.send(action: .serviceButtonDidTap(index))
            } label: {
                Text("Test")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(
                        red: 70 / 255.0,
                        green: 30 / 255.0,
                        blue: 229 / 255.0
                    ))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
        }
        .frame(height: 80)
    }
}

#Preview {
    let container = DIContainer.stub
    return PointServiceView(
        viewModel: PointServiceViewModel(
            service: container.service.pointService,
            navigationRouter: container.navigationRouter
        )
    )
    .environmentObject(container)
}




