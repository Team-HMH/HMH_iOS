//
//  PoinstServiceTestView.swift
//  NetworksDemo
//
//  Created by 류희재 on 11/21/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import SwiftUI
import Domain
import Networks
import Core

struct PoinstServiceTestView: View {
    
    private let service: PointServiceType
    private let cancelBag = CancelBag()
    
    init(service: PointServiceType) {
        self.service = service
    }
    
    var body: some View {
        HStack {
            
            Spacer()
            
            Button(action: {
                service.getEarnPoint()
                    .sink(receiveCompletion: { _ in
                        
                    }, receiveValue: { result in
                        print(result)
                    }).store(in: cancelBag)
                }, label: {
                Text("getEarnPoint")
            })
            
            Spacer()
                .frame(width: 100)
            
            Button(action: {
                service.getPointList()
                    .sink(receiveCompletion: { _ in
                        
                    }, receiveValue: { result in
                        print(result)
                    }).store(in: cancelBag)
                }, label: {
                Text("getPointList")
            })
            
            Spacer()
        }
    }
}

#Preview {
    return PoinstServiceTestView(service: StubPointService())
}


