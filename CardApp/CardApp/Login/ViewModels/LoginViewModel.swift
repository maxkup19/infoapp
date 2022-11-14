//
//  LoginViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 07.11.2022.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var userId: String = ""
    @Published var password: String = ""
    @Published var state: FetchState = .loading
    
    private let loginRepository: LoginRepository = .init()
    private let userDefaultsRepository: UserDefaultsRepository = .init()
    private let keyChainRepository: KeyChainRepository  = .init()
    private var bag = Set<AnyCancellable>()
    
    func login() {
        
        let payload = LoginPayload(userId: self.userId, password: self.password)
        
        loginRepository.login(payload: payload)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.state = .success
                    case .failure(_):
                        self?.state = .error
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    self.userDefaultsRepository.save(accessToken: response.accessToken)
                    self.userDefaultsRepository.save(expiration: response.expiration)
                    self.keyChainRepository.store(password: self.password)
                    self.keyChainRepository.store(userId: self.userId)
                })
            .store(in: &bag)
    }
}
