//
//  AuthenticatedRequestBuilder.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Comet

struct AuthenticatedRequestBuilder: AuthenticatedRequestBuilding {
    func authenticatedRequest(from request: URLRequest, with token: String) -> URLRequest {
        var authenticatedRequest = request
        authenticatedRequest.addValue(token, forHTTPHeaderField: "access_token")
        return authenticatedRequest
    }
}
