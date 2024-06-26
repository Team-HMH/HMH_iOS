//
//  StoryContentView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 4/8/24.
//

import SwiftUI

struct StoryContentView: View {
    @State var storyState = 0
    
    var body: some View {
        VStack {
            Image(getStoryImage())
            Spacer()
                .frame(height: 29)
            Image(getStoryText())
            Spacer()
                .frame(height: 40)
            Text("아무데나 눌러서 이동")
                .font(.text5_medium_16)
                .foregroundColor(.gray1)
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(.blackground, ignoresSafeAreaEdges: .all)
        .navigationBarBackButtonHidden()
        .onTapGesture {
            self.storyState += 1
            if storyState == 4 {
                UserManager.shared.appStateString = "home"
            }
        }
    }
}

extension StoryContentView {
    func getStoryImage() -> String {
        switch storyState {
        case 0:
            "StoryFirst"
        case 1:
            "StorySecond"
        case 2:
            "StoryThird"
        case 3:
            "StoryFourth"
        default:
            "StoryFirst"
        }
    }
    
    func getStoryText() -> String {
        switch storyState {
        case 0:
            "StoryTextFirst"
        case 1:
            "StoryTextSecond"
        case 2:
            "StoryTextThird"
        case 3:
            "StoryTextFourth"
        default:
            "StoryTextFirst"
        }
    }
}

#Preview {
    StoryContentView()
}
