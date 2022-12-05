//
//  NetworkManager.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 10.11.2022.
//

import Foundation
import Combine

final class NetworkManager {
    
    static func performRequest<ResponseObject: Codable> (for urlString: String, with payload: NetwokManagerPayload, responseType: ResponseObject.Type) -> AnyPublisher<ResponseObject, NetworkManagerError> {
        
        let request = Just(URL(string: urlString))
            .flatMap { url -> AnyPublisher<URLRequest, NetworkManagerError> in
                guard let url else {
                    return Fail(error: NetworkManagerError.urlCreationFailed)
                        .eraseToAnyPublisher()
                }
                
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = payload.method
                
                if let httpBody = payload.httpBody {
                    urlRequest.httpBody = httpBody
                }
                
                // MARK: for each from headers
                
                payload.headers.forEach { (field, value) in
                    urlRequest.setValue(value, forHTTPHeaderField: field)
                }
                
                if payload.authentorized {
                    urlRequest.setValue(UserDefaultsRepository().accessToken,
                                        forHTTPHeaderField: "access_token")
                }
                
                return Just(urlRequest)
                    .setFailureType(to: NetworkManagerError.self)
                    .eraseToAnyPublisher()
            }
            .flatMap { urlRequest in
                URLSession.shared.dataTaskPublisher(for: urlRequest)
                    .mapError(NetworkManagerError.networkError)
                    .eraseToAnyPublisher()
            }
        
        return request
            .flatMap { output -> AnyPublisher<Data, NetworkManagerError> in
                
                guard let httpResponse = output.response as? HTTPURLResponse
                else {
                    return Fail(error: NetworkManagerError.apiError)
                        .eraseToAnyPublisher()
                }
                
                if httpResponse.statusCode == 401 {
                    return Fail(error: NetworkManagerError.authenticationError)
                        .eraseToAnyPublisher()
                }
                
                guard 200..<300 ~= httpResponse.statusCode
                else {
                    return Fail(error: NetworkManagerError.apiError)
                        .eraseToAnyPublisher()
                }
                
                return Just(output.data)
                    .setFailureType(to: NetworkManagerError.self)
                    .eraseToAnyPublisher()
            }
            .decode(type: responseType.self, decoder: JSONDecoder())
            .mapError { error in NetworkManagerError.decodingError(error) }
            .print()
            .eraseToAnyPublisher()
    }
}
