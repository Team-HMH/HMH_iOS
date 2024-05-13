//
//  CreateChallengeResponseDTO.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/12/24.
//

import Foundation

struct CreateChallengeResponseDTO: Codable {
    let challengeID: Int

    enum CodingKeys: String, CodingKey {
        case challengeID = "challengeId"
    }
}
