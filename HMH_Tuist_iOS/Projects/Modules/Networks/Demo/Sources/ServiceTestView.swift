//
//  ServiceTestView.swift
//  NetworksDemo
//
//  Created by 류희재 on 11/22/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI
import Networks
import Core

struct ServiceTestView: View {
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("뒤로 가기")
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
            
            ServiceListView()
                .padding(.horizontal, 20)
                .padding(.bottom, 25)
                .frame(height: 360)
            
            Rectangle()
                .foregroundColor(.white)
                .frame(width: .infinity, height: 3)
                .padding(.horizontal, 20)
                .padding(.bottom, 25)
            
            Text("결과창")
                .padding(.top, 25)
                .padding(.horizontal, 20)
                .frame(width: 335, height: 240)
                .background(.gray)
            
            Spacer()
        }
        .background(Color(asset: NetworksDemoAsset.blackground))
    }
}

//ForEach($viewModel.missionList) { $mission in
//    Service(viewModel: viewModel, mission: $mission)
//        .padding(.bottom, 16)
//}
fileprivate struct ServiceListView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 24)
            
            ScrollView(.vertical, showsIndicators: true) {
                ServiceCellView()
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: .infinity, height: 1)
                ServiceCellView()
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: .infinity, height: 1)
                ServiceCellView()
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: .infinity, height: 1)
                ServiceCellView()
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: .infinity, height: 1)
                ServiceCellView()
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: .infinity, height: 1)
                ServiceCellView()
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: .infinity, height: 1)
                ServiceCellView()
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: .infinity, height: 1)
                ServiceCellView()
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: .infinity, height: 1)
                ServiceCellView()
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: .infinity, height: 1)
                ServiceCellView()
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: .infinity, height: 1)
            }
        }
    }
}

fileprivate struct ServiceCellView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("PatchPointUse")
                    .foregroundStyle(Color(
                        red: 219 / 255.0,
                        green: 218 / 255.0,
                        blue: 231 / 255.0
                    ))
                    .font(.title2)
                    .bold()
                    .frame(height: 2)
                    .padding(.bottom, 10)
                
                Text("✅ 성공 or ❌ 실패")
                    .foregroundColor(.white)
                    .font(.body)
                    .bold()
            }
            .padding(.vertical, 18)
            
            Spacer()
            
            Button {
                
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
    return ServiceTestView()
}




