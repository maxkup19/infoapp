//
//  Login.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 07.11.2022.
//

import Foundation

struct LoginPayload: Codable, Equatable, Hashable {
    let userId: String
    let password: String
    let timeToLive: Int = Configuration.timeToLive
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case password
        case timeToLive = "time-to-live"
    }
}

struct LoginResponse: Codable, Equatable, Hashable {
    let expiration: String
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case expiration = "$expiration"
        case accessToken = "access_token"
    }
}
