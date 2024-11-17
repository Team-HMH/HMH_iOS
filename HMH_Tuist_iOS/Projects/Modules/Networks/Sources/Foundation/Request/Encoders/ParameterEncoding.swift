//
//  ParameterEncoding.swift
//  Networks
//
//  Created by 류희재 on 11/10/24.
//  Copyright © 2024 HMH-iOS. All rights reserved.
//

import Foundation
import Combine

//TODO: 필요없어진 파일 but 혹시 모르니까
/*
    확장성보다는 테스트 용이성에 초점을 두었다
    사실 Task는 이미 Parameter타입과 Encodable 타입으로 객체를 받아오고 있는데
    프로토콜을 준수해야한다는 목적으로 인해서 encode에서 한번더 타입을 확인하는 불필요한 과정을 거치게 된다.
 
    그래서 각각의 JsonEncoding, URLEncoding을 프로토콜로 만들고 각각의 encode를 준수한뒤, 각각에 MockEncoder를 만들어서 테스트하는것이 맞다고 생각을 했다.
 */

//public protocol ParameterEncoding {
//    func encode(_ request: URLRequest, with parameters: Any?) -> AnyPublisher<URLRequest, HMHNetworkError.ParameterEncodingError>
//}

