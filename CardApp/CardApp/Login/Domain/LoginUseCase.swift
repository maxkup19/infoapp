//
//  LoginUseCase.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Combine

protocol LoginUseCaseProtocol {
    func login(payload: Login) -> AnyPublisher<LoginResponse, NetworkManagerError>
}

final class LoginUseCase: LoginUseCaseProtocol {
    private let loginRepo: LoginRepositoryProtocol
    
    init(loginRepo: LoginRepositoryProtocol) {
        self.loginRepo = loginRepo
    }
    
    func login(payload: Login) -> AnyPublisher<LoginResponse, NetworkManagerError> {
        loginRepo.login(payload: payload)
    }
}
