//
//  Login.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 07.11.2022.
//

import Foundation

struct Login: Codable, Equatable, Hashable {
    let userId: String
    let password: String
    let timeToLive: Int = Configuration.timeToLive
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case password
        case timeToLive = "time-to-live"
    }
}
