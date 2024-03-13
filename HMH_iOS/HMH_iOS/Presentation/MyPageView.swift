//
//  MyPageView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/12/24.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        Text("myPage")
            .foregroundColor(.white) // Set text color to white
            .padding() // Add some padding around the text
            .frame(maxWidth: .infinity, maxHeight: .infinity) 
            .background(Color.red) 
    }
}

#Preview {
    MyPageView()
}
