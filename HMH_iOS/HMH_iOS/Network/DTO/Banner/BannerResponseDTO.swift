//
//  BannerResponseDTO.swift
//  HMH_iOS
//
//  Created by 이지희 on 11/24/24.
//

import SwiftUI

struct BannerResponseDTO: Codable {
    let title: String
    let subTitle: String
    let imageUrl: String
    let linkUrl: String
    let backgroundColors: [String]
}

struct homeBannerModel {
    let title: String
    let subTitle: String
    let imageUrl: String
    let linkUrl: String
    let backgroundColors: [Color]
}
