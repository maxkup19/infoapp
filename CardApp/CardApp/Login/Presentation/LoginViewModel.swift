//
//  LoginViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 07.11.2022.
//

import Foundation
import Combine
import CombineExtensions

protocol LoginViewModelProtocol: ObservableObject {
    var userId: String { get set }
    var password: String { get set }
    var state: FetchState { get set }
    
    var showError: Bool { get set }
    
    func login()
}

final class LoginViewModel: LoginViewModelProtocol {
    
    @Published var userId: String = ""
    @Published var password: String = ""
    @Published var showError: Bool = false
    @Published var state: FetchState = .loading
    
    private let loginUseCase: LoginUseCaseProtocol
    private let userDefaultsRepository: UserDefaultsRepository = .init()
    private let keyChainRepository: KeyChainRepository  = .init()
    private var bag = Set<AnyCancellable>()
    
    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
    
    func login() {
        
        let payload = Login(userId: self.userId, password: self.password)
        
        loginUseCase.login(payload: payload)
            .receive(on: DispatchQueue.main)
            .sink(
                weak: self,
                receiveCompletion: { unwrappedSelf, completion in
                    switch completion {
                    case .finished:
                        unwrappedSelf.state = .success
                    case .failure(_):
                        unwrappedSelf.state = .error
                    }
                },
                receiveValue: { unwrappedSelf, response in
                    unwrappedSelf.userDefaultsRepository.save(accessToken: response.accessToken)
                    unwrappedSelf.userDefaultsRepository.save(expiration: response.expiration)
                    unwrappedSelf.keyChainRepository.store(password: unwrappedSelf.password)
                    unwrappedSelf.keyChainRepository.store(userId: unwrappedSelf.userId)
                    LoginRepository.loggedIn = true
                })
            .store(in: &bag)
    }
}
