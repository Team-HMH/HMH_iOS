//
//  SwiftUIView.swift
//  Data
//
//  Created by 류희재 on 11/2/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI
import Domain
import Networks
import Core

struct NetworkTestUI: View {
    
    private let repository: AuthRepositoryType
    private let cancelBag = CancelBag()
    
    init(repository: AuthRepositoryType) {
        self.repository = repository
    }
    
    var body: some View {
        HStack {
            
            Spacer()
            
            Button(action: {
                repository.authorize(.kakao)
                    .sink(receiveCompletion: {_ in 
                        
                    }, receiveValue: { token in
                        print("카카오 토큰은  \(token)")
                    })
                    .store(in: cancelBag)
            }, label: {
                Text("카카오 버튼")
            })
            
            Spacer()
                .frame(width: 100)
            
            Button(action: {
                repository.authorize(.apple)
                    .sink(receiveCompletion: {_ in
                        
                    }, receiveValue: { token in
                        print("애플 토큰은  \(token)")
                    })
                    .store(in: cancelBag)
            }, label: {
                Text("애플 버튼")
            })
            
            Spacer()
        }
    }
}

#Preview {
    return NetworkTestUI(
        repository: AuthRepository(
            authService: AuthService(),
            oauthServiceFactory: OAuthServiceFactory()
        )
    )
}
            
