//
//  StudentDetailError+Extension.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 05.12.2022.
//

import Foundation
import Comet

extension StudentDetailError {
    static func replace(error: CometClientError) -> StudentDetailError {
        switch error {
        case .internalError:
            return .internalError
        case .unauthorized:
            return .unauthorized
        case .loginRequired:
            return .loginRequired
        case .parserError(reason: _):
            return .parserError
        case .networkError(from: _):
            return .networkError
        case .clientError(error: _):
            return .clientError
        case .serverError(error: _):
            return .serverError
        case .unknownError(error: _):
            return .unknownError
        }
    }
}
