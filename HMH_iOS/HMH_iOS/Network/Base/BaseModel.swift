//
//  BaseModel.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/11/24.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    var status: Int
    var message: String?
    var data: T?
}
