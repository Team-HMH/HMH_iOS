import SwiftUI

import Lottie

struct HomeView: View {
    
    //@StateObject var usageTimeData = HomeViewModel()
    
    var body: some View {
        ZStack {
            Color(.blackground)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                ZStack(alignment: .topLeading) {
                    LottieView(animation: .named("Main-A-final.json"))
                        .playing(loopMode: .autoReverse)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text(StringLiteral.Home.usageStatusA)
                        .font(.text1_medium_22)
                        .foregroundStyle(.whiteText)
                        .frame(alignment: .topLeading)
                        .padding(EdgeInsets(top: 8,
                                            leading: 20,
                                            bottom: 0,
                                            trailing: 0))
                }
                Text("목표 사용 시간 3시간 중")
                    .font(.detail4_medium_12)
                    .foregroundStyle(.gray2)
                    .frame(alignment: .leading)
                    .padding(EdgeInsets(top: 0,
                                        leading: 20,
                                        bottom: 0,
                                        trailing: 0))
                Text("20분 사용")
                    .font(.title2_semibold_24)
                    .foregroundStyle(.whiteText)
                    .padding(EdgeInsets(top: 2,
                                        leading: 20,
                                        bottom: 0,
                                        trailing: 0))
                ProgressView(value: 3, total: 10)
                    .foregroundStyle(.gray5)
                    .padding(EdgeInsets(top: 0,
                                        leading: 20,
                                        bottom: 0,
                                        trailing: 20))
                    .tint(.whiteText)
                List {
                    
                }
                
                
                
            }
        }
        
    }
}

extension HomeView {
    enum lottie {
        case statusA 
        case statusB
        case statusC
        case statusD
        case statusE
    }
}

#Preview {
    HomeView()
}
