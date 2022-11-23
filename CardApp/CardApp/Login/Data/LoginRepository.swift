//
//  LoginRepository.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 07.11.2022.
//

import Foundation
import Combine

final class LoginRepository: LoginRepositoryProtocol {
    
    static var loggedIn: Bool = false
    
    static var tokenExists: Bool {
        let userDefaultsRepository: UserDefaultsRepository = .init()
        
        guard userDefaultsRepository.accessToken != nil else { return false }
        guard userDefaultsRepository.expiration != nil else { return false }
        
        return true
    }
    
    func login(payload: Login) -> AnyPublisher<LoginResponse, NetworkManagerError> {
        
        let payload: NetwokManagerPayload = .init(method: "POST",
                                                  httpBody: try? JSONEncoder().encode(payload),
                                                  headers: ["application/json": "Content-Type"],
                                                  authentorized: false)
        
        let request = NetworkManager
            .performRequest(
                for: "http://emarest.cz.mass-php-1.mit.etn.cz/api/v2/login?sleepy=\(Configuration.sleepy)&badServer=\(Configuration.badServer)",
                with: payload,
                responseType: LoginResponse.self)
        
        return request
    }
    
    func updateToken() -> AnyPublisher<LoginResponse, NetworkManagerError> {
        
        let keyChainRepo = KeyChainRepository()
        
        guard let userId = keyChainRepo.readUserId(),
              let password = keyChainRepo.readPassword() else {
            return Fail(error: NetworkManagerError.urlCreationFailed)
                .eraseToAnyPublisher()
        }
        
        return self.login(payload: Login(userId: userId, password: password))
    }
}
