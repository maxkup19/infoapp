//
//  NetworkManagerError.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 12.11.2022.
//

import Foundation

enum NetworkManagerError: Error {
    case urlCreationFailed
    case networkError(URLError)
    case authenticationError
    case apiError
    case decodingError(Error)
}
