//
//  RequestBuilder.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Combine

final class RequestBuilder {
    static func createRequest(for urlString: String, with payload: NetwokManagerPayload) -> URLRequest {
        
        let url = URL(string: urlString)
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = payload.method
        
        if let httpBody = payload.httpBody {
            urlRequest.httpBody = httpBody
        }
        
        // MARK: for each from headers
        
        payload.headers.forEach { (field, value) in
            urlRequest.setValue(value, forHTTPHeaderField: field)
        }
        
        return urlRequest
    }
}
