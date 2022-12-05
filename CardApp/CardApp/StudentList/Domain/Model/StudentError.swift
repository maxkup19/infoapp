//
//  StudentError.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 05.12.2022.
//

import Foundation

enum StudentError: Error {
    case internalError
    case unauthorized
    case loginRequired
    case parserError
    case networkError
    case clientError
    case serverError
    case unknownError
}
