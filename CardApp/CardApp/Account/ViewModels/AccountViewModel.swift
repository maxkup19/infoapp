//
//  AccountViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 07.11.2022.
//

import Foundation
import Combine

protocol AccountViewModelProtocol: ObservableObject {
    var loggedIn: Bool { get set }
    var studentId: String { get }
    
    var showLoginPage: Bool { get set }
}

class AccountViewModel: AccountViewModelProtocol {
    @Published var loggedIn: Bool = false 
    @Published var showLoginPage: Bool = false
    private let keyChainRepo = KeyChainRepository()
    var studentId: String { self.keyChainRepo.readUserId() ?? "" }
    
    init() {
        self.loggedIn = LoginRepository.tokenExists
    }
}
