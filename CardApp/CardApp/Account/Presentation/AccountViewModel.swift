//
//  AccountViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 07.11.2022.
//

import Foundation
import Combine
import LocalAuthentication

protocol AccountViewModelProtocol: ObservableObject {
    var loggedIn: Bool { get set }
    var studentId: String { get }
    var showLoginPage: Bool { get set }
    
    func login()
}

class AccountViewModel: AccountViewModelProtocol {
    @Published var loggedIn: Bool = false
    @Published var showLoginPage: Bool = false
    private let keyChainRepo = KeyChainRepository()
    var studentId: String { self.keyChainRepo.readUserId() ?? "" }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "DO IT"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    DispatchQueue.main.async {
                        self.loggedIn = true
                        LoginRepository.loggedIn = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showLoginPage = true
                    }
                }
            }
            
        } else {
            DispatchQueue.main.async {
                self.loggedIn = false
                self.showLoginPage = true
            }
        }
    }
    
    func login() {
        if  LoginRepository.tokenExists {
            authenticate()
        } else {
            self.showLoginPage = true
        }
    }
}
