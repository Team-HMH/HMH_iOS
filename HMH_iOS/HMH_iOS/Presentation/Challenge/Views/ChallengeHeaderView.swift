//
//  ChallengeHeaderView.swift
//  HMH_iOS
//
//  Created by 이지희 on 7/31/24.
//

import SwiftUI

struct ChallengeHeaderView: View {
    @ObservedObject var viewModel: ChallengeViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Image(.challengeBackground)
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text("\(viewModel.visableStartDate) 시작부터")
                    .font(.text5_medium_16)
                    .foregroundStyle(.gray1)
                    .padding(.top, 14)
                Text("\(viewModel.todayIndex + 1)일차")
                    .font(.title1_semibold_32)
                    .foregroundStyle(.whiteText)
                    .padding(.top, 2)
                    .padding(.bottom, 32)
                if viewModel.challengeType != .empty {
                    ChallengeWeekView(viewModel: viewModel)
                        .frame(width: UIScreen.main.bounds.width * 0.9)
                        .padding(.bottom, 20)
                }
            }
        }
    }
}

struct ChallengeWeekView: View {
    @ObservedObject var viewModel: ChallengeViewModel

    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.days > 0 {
                ForEach(1...min((viewModel.days + 6) / 7, (viewModel.days + 6) / 7), id: \.self) { week in
                    challengeWeekRow(week: week)
                }
            }
        }
    }
    
    @ViewBuilder
    private func challengeWeekRow(week: Int) -> some View {
        HStack {
            ForEach(1...7, id: \.self) { day in
                challengeDayCell(week: week, day: day)
            }
        }
        .padding(.bottom, 8)
    }
    
    @ViewBuilder
    private func challengeDayCell(week: Int, day: Int) -> some View {
        let index = (week - 1) * 7 + day - 1
        if index < viewModel.statuses.count {
            VStack {
                Text("\(index + 1)")
                    .font(.text6_medium_14)
                    .foregroundStyle(.gray2)
                ZStack {
                    Circle()
                        .stroke(index == viewModel.todayIndex ? .bluePurpleOpacity70 : .gray6, lineWidth: 2)
                        .frame(width: 44, height: 44)
                    switch viewModel.statuses[index] {
                    case "FAILURE":
                        Image(.failStar)
                            .resizable()
                            .frame(width: 24, height: 24)
                    case "UNEARNED", "EARNED":
                        let gradient = LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color(red: 61/255, green: 23/255, blue: 211/255, opacity: 0), location: 0),
                                .init(color: Color(red: 61/255, green: 23/255, blue: 211/255, opacity: 0.4), location: 1)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        gradient
                            .mask(Circle().frame(width: 44, height: 44))
                            .frame(width: 44, height: 44)
                        Image(.successStar)
                            .resizable()
                            .frame(width: 24, height: 24)
                    default:
                        EmptyView()
                    }
                }
            }
        }
    }
}

struct ChallengeWeekView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeWeekView(viewModel: ChallengeViewModel())
    }
}
