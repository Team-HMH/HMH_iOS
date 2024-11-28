//
//  ServiceButton.swift
//  NetworksDemo
//
//  Created by 류희재 on 11/24/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI
import Core

struct ServiceButton : View {
    
    let imageResource: ImageResource
    let backgroundColor: Color
    let title: String
    let action: () -> Void
    
    internal var body: some View {
        Button {
            action()
        } label: {
            
            VStack {
                Image(imageResource)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                Text(title)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(.top, 7)
                
            }
            .frame(width: 145, height: 145)
            .background(backgroundColor)
            .multilineTextAlignment(.center)
            .shadow(radius: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.white), lineWidth: 1)
            )
        }
    }
}
