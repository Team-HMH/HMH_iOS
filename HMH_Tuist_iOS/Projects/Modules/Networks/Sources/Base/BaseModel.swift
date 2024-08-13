//
//  BaseModel.swift
//  HMH_iOS
//
//  Created by 이지희 on 5/12/24.
//

import Foundation

public struct BaseResponse<T: Decodable>: Decodable {
    public var status: Int
    public var message: String?
    public var data: T?
}
