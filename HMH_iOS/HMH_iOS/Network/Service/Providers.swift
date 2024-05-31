//
//  Providers.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/12/24.
//

import Foundation
import Moya

struct Providers {
    static let challengeProvider = NetworkProvider<ChallengeRouter>(withAuth: true)
    static let myPageProvider = NetworkProvider<MyPageRouter>(withAuth: true)
    static let AuthProvider = NetworkProvider<AuthRouter>(withAuth: false)
    static let pointProvider = NetworkProvider<PointRouter>(withAuth: false)
}

extension MoyaProvider {
    convenience init(withAuth: Bool) {
        if withAuth {
            self.init(session: Session(interceptor: AuthInterceptor.shared),
                      plugins: [MoyaLoggingPlugin()])
        } else {
            self.init(plugins: [MoyaLoggingPlugin()])
        }
    }
}
