//
//  LoginResponse.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation

struct LoginResponse: Codable, Equatable, Hashable {
    let expiration: String
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case expiration = "$expiration"
        case accessToken = "access_token"
    }
}
