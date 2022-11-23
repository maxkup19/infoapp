//
//  LoginRepositoryProtocol.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 23.11.2022.
//

import Foundation
import Combine

protocol LoginRepositoryProtocol {
    static var tokenExists: Bool { get }
    func login(payload: Login) -> AnyPublisher<LoginResponse, NetworkManagerError>
    func updateToken() -> AnyPublisher<LoginResponse, NetworkManagerError>
}
