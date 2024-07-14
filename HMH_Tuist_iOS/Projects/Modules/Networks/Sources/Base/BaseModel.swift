//
//  BaseModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/12/24.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    var status: Int
    var message: String?
    var data: T?
}
