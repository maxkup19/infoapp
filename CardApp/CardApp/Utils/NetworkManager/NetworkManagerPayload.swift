//
//  NetworkManagerPayload.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 12.11.2022.
//

import Foundation

struct NetwokManagerPayload {
    let method: String
    let httpBody: Data?
    let headers: [String: String]
    let authentorized: Bool
}
