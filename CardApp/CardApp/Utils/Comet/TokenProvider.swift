//
//  TokenProvider.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Comet
import Combine

struct TokenProvider: TokenProviding {
    
    private let userDefaultsRepository = UserDefaultsRepository()
    private let keyChainRepository = KeyChainRepository()
    private let loginRepo: LoginRepositoryProtocol = LoginRepository()
    
    private var bag = Set<AnyCancellable>()
    
    var accessToken: AnyPublisher<String, TokenProvidingError> {
        guard let token = userDefaultsRepository.accessToken else {
            return Fail(error: TokenProvidingError.noToken)
                .eraseToAnyPublisher()
        }
        
        return Just(token)
            .setFailureType(to: TokenProvidingError.self)
            .eraseToAnyPublisher()
    }
    
    var refreshAccessToken: AnyPublisher<String, TokenProvidingError> {
        loginRepo.updateToken()
            .mapError { _ in TokenProvidingError.internalError}
            .flatMap { response -> AnyPublisher<String, TokenProvidingError> in
                userDefaultsRepository.save(expiration: response.expiration)
                userDefaultsRepository.save(accessToken: response.accessToken)
                
                return Just(response.accessToken)
                    .setFailureType(to: TokenProvidingError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
